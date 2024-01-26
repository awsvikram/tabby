FROM python:3

RUN apt-get update \
    && apt-get install -y nano vim \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /app

COPY . /app
COPY tabpy.conf /etc/tabpy.conf
COPY secret.txt /app/secret.txt
RUN chmod 644 /etc/tabpy.conf 
RUN rm /app/tabpy.conf


# install the latest TabPy
RUN python3 -m pip install --upgrade pip && python3 -m pip install --upgrade tabpy

RUN tabpy-user add -u vikrvenk -f /app/secret.txt -p Password1!

# start TabPy
CMD ["sh", "-c", "tabpy"]

# run startup script
ADD start.sh /
RUN chmod +x /start.sh
CMD ["/start.sh"]
