import os
import requests
import json

from dotenv import load_dotenv

load_dotenv()
api_key = os.getenv('TMDB_API_KEY')
api_url = "https://api.themoviedb.org/3/"

def getResponse(URL, PARAMS):
    response = requests.get(url = URL, params = PARAMS)
    json_formatted_str = json.dumps(response.json(), indent=2)
    # print(json_formatted_str)
    # writeFile(json_formatted_str)
    return json_formatted_str

def writeFile(json):
    with open("movie.json", "w") as outfile:
        outfile.write(json)

def searchMovieByID(movie_id):
    URL = api_url + "movie/" + movie_id
    PARAMS = {
        "api_key":api_key
    }
    json_string = getResponse(URL, PARAMS)

def searchMovie(movie_string):
    URL = api_url + "search/movie"
    PARAMS = {
        "api_key":api_key,
        "query":movie_string
    }
    json_string = getResponse(URL, PARAMS)
    json_data = json.loads(json_string)
    parseJSON(json_data)
    #test

def parseJSON(data):
    if len(data['results']) == 0:
        print("no movie found")
    else:
        movie_string = data['results'][0]['title']
        movie_date = data['results'][0]['release_date']
        movie_year = movie_date[0:4]
        print(movie_string + " (" + movie_year + ")")

if __name__ == "__main__":
    # searchMovie("Fight Club")
    # file = open('movie.json')
    # data = json.load(file)
    # parseJSON(data)
    print("Movie: ", end='')
    input = input()  
    searchMovie(input)