FROM python:3.7.3
WORKDIR /service/
COPY requirements.txt  ./
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && \
    apt-get install -y vim && \
    pip install --upgrade pip && \
    pip install -r requirements.txt && \
    python -m nltk.downloader stopwords && \
    mkdir /service/scripts/ && \
    mkdir /service/scripts/log/ && \
    mkdir /service/model
COPY model /service/model
COPY scripts /service/scripts
ENTRYPOINT ["python", "/service/scripts/ConsumerKafka.py"]
