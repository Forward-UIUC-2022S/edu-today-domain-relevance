FROM python:3.8

RUN mkdir domain-relevance
WORKDIR ./domain-relevance

ADD ./term-lists/ ./term-lists/
ADD ./lemmatizer.py .
ADD ./model.py .
ADD ./query.py .
ADD ./run.py .
ADD ./utils.py .
ADD ./requirements.txt .

# downloading the other features
RUN apt install unzip
RUN pip3 install gdown
RUN gdown --folder https://drive.google.com/drive/folders/1wh4qQj5ALNjsIpwi_6UVO-qA86Epx7w3
RUN mv ./domain-relevance/* .
RUN unzip wikipedia.zip
RUN unzip features.zip
RUN rm wikipedia.zip
RUN rm features.zip

# Getting glove embeddings
# RUN mkdir features
RUN wget https://nlp.stanford.edu/data/glove.6B.zip
RUN unzip glove.6B.zip
RUN mv ./glove.6B.100d.txt ./features/glove.6B.100d.txt
RUN rm ./glove.6B.zip
RUN rm glove.6B.50d.txt
RUN rm glove.6B.200d.txt
RUN rm glove.6B.300d.txt

# installing requirements
RUN pip3 install torch==1.11.0
RUN pip3 install torch-scatter -f https://data.pyg.org/whl/torch-1.11.0+cpu.html
RUN pip3 install torch-sparse -f https://data.pyg.org/whl/torch-1.11.0+cpu.html
RUN pip3 install torch-geometric
RUN pip3 install -r requirements.txt

CMD ["python", "run.py", "--domain cs", " --method cfl"]






