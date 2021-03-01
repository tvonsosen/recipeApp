# Dennis did this part of the project

# library imports
from flask import Flask, make_response,request
import json
import requests
import base64
import random
from flask_cors import CORS, cross_origin
import string
import os,io 
from google.cloud import vision_v1
from google.cloud.vision_v1 import types 
import pandas as pd
import numpy as np 
import spacy
import re

os.environ['GOOGLE_APPLICATION_CREDENTIALS']=r"D:\coding\hackathon\recipe\VisionApiTest\token.json" # set env variable
# variable setup
nlp = spacy.load('en_core_web_sm',disable=['ner','textcat'])
client = vision_v1.ImageAnnotatorClient() 


def getTitle(lines):
    ''' Function to return title from array of lines
    '''
    # leave simple for now
    return lines[0]

def getData(lines):
    ''' Function that returns a dict (hashmap) with keys (title,ingredients, instruct) 
    '''
    block=''.join(lines)
    servings=re.findall(r"Serv.+?(\d)",block,flags=re.IGNORECASE)[0]
    
    ing=[]
    instructions=[]
    for line in lines:
        docs=nlp(line)
        if len(docs)<=3:continue
        amount=None
        measurement=None
        desc=''

        if docs[0].pos_=="NUM" or docs[0].text=='%':
            amount=docs[0].text
            measurement=docs[1].text
            for i in range(2,len(docs)):
                desc+=docs[i].text+' '
            ing.append({"amount":amount,"measurment":measurement,"desc":desc.strip()})
        elif docs[0].text.isnumeric() and docs[1].text=='.':
            step=''
            for i in range(2, len(docs)): step+=docs[i].text+' '
            instructions.append(step.strip())
    return {"title":getTitle(lines),"ingredients":ing,"instructions":instructions,"servings":servings[0]}

def handleImage(base):
    ''' Handles base64 encoded image.
    ''' 
    content=base64.b64decode(base)
    image=vision_v1.types.Image(content=content)
    response= client.text_detection(image=image)
    texts=response.text_annotations
    df=pd.DataFrame(columns=['locale','description'])
    for text in texts:
        df=df.append(
            dict(locale=text.locale,description=text.description),
            ignore_index=True
    )
    return getData(list(df['description'])[0].split("\n"))
    

app=Flask(__name__)

def nice_json(arg):
    ''' Create nice json response
    '''
    response=make_response(json.dumps(arg,sort_keys=True,indent=4))
    response.headers['Content-type']="application/json"
    return response



@app.route("/findRecipe",methods=['POST'])
@cross_origin(origin="*")
def handle():
    ''' Create handler for route "/findRecipe" where the base64 encoded image should be passed as a POST param "image" 
    '''
    for i in request.form:
        print(i)
    try:
        return nice_json(handleImage(request.form["image"]))
    except Exception as e:
        print(e)
        return nice_json({"error":str(e)})
    
@app.route('/', defaults={'u_path': ''})
@app.route('/<path:u_path>')
@cross_origin(origin="*")
def root(u_path):
    return nice_json({
        "unknownRoute":"If you would like to recognize a recipe from an image send a POST request to /findRecipe with the param 'image' being the base64 encoded image!"
    })

if __name__=='__main__':
    print("Starting on port 3000")
    app.run(port=3000,debug=True)
