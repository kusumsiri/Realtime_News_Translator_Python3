import asyncio
import boto3
import urllib3
import json
import os

url = 'https://newsapi.org/v2/top-headlines?country=de&category=technology&pageSize=1&apiKey=' + os.environ.get('NEWS_API_KEY')

async def translate():
    # Featch API reply from newsapi.org/ API Gateway
    http = urllib3.PoolManager() 
    response = http.request("GET", url)
    data = response.data.decode()
    data = json.loads(data)

    if response.status >= 200 and response.status < 300:
        title = data["articles"][0]["title"] 
    else:
        title = data["message"]

    await asyncio.sleep(1)

    # use Google translater  API
    translate = boto3.client(service_name='translate', region_name='eu-west-1', use_ssl=True)
    result = translate.translate_text(Text=title, SourceLanguageCode="de", TargetLanguageCode="en")
    
    return (result.get('TranslatedText'))    

def lambda_handler(event, context):
    return {
        'statusCode': 200,
        'body': json.dumps(asyncio.run(translate()))
    }