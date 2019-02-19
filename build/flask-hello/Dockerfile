FROM python:2.7

RUN pip install Flask
COPY . /

ENV FLASK_APP=hello.py 
EXPOSE 5000

CMD flask run --host=0.0.0.0