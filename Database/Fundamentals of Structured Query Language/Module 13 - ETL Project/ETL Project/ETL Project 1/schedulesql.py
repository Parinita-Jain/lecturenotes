import schedule
import time
import pandas as pd
import MySQLdb as dbapi
import sys
import csv
import sqlalchemy
from datetime import datetime

def job():
    print("Creating files every 5 seconds ...")
    QUERY = 'SELECT * FROM employees.employees limit 10;' 
    db=dbapi.connect(host='localhost',user='siddhs',passwd='password')
    cur=db.cursor()
    cur.execute(QUERY)
    result=cur.fetchall()
    columns = ['emp_no','birth_date','first_name','last_name','gender','hire_date'] 
    df = pd.DataFrame.from_records(data = result,columns = columns)
    df.to_csv('./Desktop/TEST/TEST'+str(datetime.now())+'.csv')
    
def job1():
    print("Creating files every 10 seconds ...")
    QUERY = 'select emp_no, birth_date, gender from employees.employees limit 10;' 
    db=dbapi.connect(host='localhost',user='siddhs',passwd='password')
    cur=db.cursor()
    cur.execute(QUERY)
    result=cur.fetchall()
    columns = ['emp_no','birth_date','gender'] 
    df = pd.DataFrame.from_records(data = result,columns = columns)
    df.to_csv('./Desktop/TEST/TEXT'+str(datetime.now())+'.csv')

schedule.every(5).seconds.do(job)
schedule.every(10).seconds.do(job1)
# schedule.every().hour.do(job)
# schedule.every().day.at("10:30").do(job)
# schedule.every().monday.do(job)
# schedule.every().wednesday.at("13:15").do(job)

def main():
    while True:
        schedule.run_pending()
        time.sleep(1)


if __name__=="__main__":
    main()
