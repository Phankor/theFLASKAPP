FROM python:latest
WORKDIR /td9_bm1
COPY "app.py" .
COPY "requirements.txt" .
COPY "config.py" .
ADD templates templates
ADD tests tests
COPY "model_saved" .

RUN pip install -r requirements.txt

RUN wget https://raw.githubusercontent.com/vishnubob/wait-for-it/master/wait-for-it.sh -P /scripts
RUN chmod +x /scripts/wait-for-it.sh
ENTRYPOINT ["/scripts/wait-for-it.sh", "db:5432", "--"]

CMD [ "python" , "app.py" , "runserver" , "--host=0.0.0.0" , "--threaded" ]