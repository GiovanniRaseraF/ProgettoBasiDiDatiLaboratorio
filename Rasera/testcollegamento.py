#!/usr/bin/python3

import psycopg2 as db

conn = db.connect(
    host = "172.16.150.231",
    database = "LorisTest",
    user = "postgres",
    password = "fdsa" 
)

executor = conn.cursor()

executor.execute("insert hello.bello ('ciao', 1);")

executor.close()

