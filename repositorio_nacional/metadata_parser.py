#small code to add metadata to the dissertations

import unidecode
import os 
import pandas as pd
import csv

def tesisToText(tesis):
    file = f+".txt"
    archivo = open(file, 'r', encoding="ISO-8859-1")
    text = archivo.read().replace('"',"'")
    archivo.close()
    return text

os.chdir("/home/rod/Dropbox/Colmex/meta-tesis/tesis_n") 
#os.chdir("/Dropbox/meta-tesis/tesis_txt") 
df = pd.DataFrame(pd.read_csv('../theses_metadata.csv'))

toCSV = []
num = 1
notFound = []

open("../not_found.txt","w").close()

for f in os.listdir():
    row = {}
    f = f[:-4]

#check if file name is in the metadata csv (theses_metadata.csv)   
    query = df.loc[df['Repo_name'] == f+".pdf"]
    query = query.to_dict(orient='records')
   
    if len(query) > 0:   
       
        #"body" is commented just to get metadata without full-text
        row["Doc_number"] = num
        row["external_id"] = query[0]["identifier"]
        row["article_date"] = "01.10."+ str(query[0]["Date"])
        row["title"] = query[0]["Title"].replace('"','')
        # row["Body"] = tesisToText(f)
        row["source"] = query[0]["Centro"]
        row["subtitle"] = ""
        row["author"] = query[0]["creator"]
        row["publisher"] = ""
        row["language"] = query[0]["language"]
        row["publication_type"] = query[0]["Grado"]
        row["section"] = ""
        row["subject"] = query[0]["Subject"]
        row["page"] = ""
        toCSV.append(row)
    else:
        with open("../not_found.txt", 'a') as file:
             file.write(f+".txt \n") 
        
    
    
    num +=1
   
keys = toCSV[0].keys()
#Name of the csv depending if it has body commented or not
with open('../theses_metadata.csv', 'w') as output_file:
    dict_writer = csv.DictWriter(output_file, keys, quotechar='\"', quoting=csv.QUOTE_NONNUMERIC,delimiter=',')
    dict_writer.writeheader()
    dict_writer.writerows(toCSV)
    
