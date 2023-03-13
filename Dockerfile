# syntax = docker/dockerfile:1

## Loosely inspired by:
## github.com/smizy/docker-scikit-learn
## github.com/petronetto/machine-learning-alpine

## DOCKER_BUILDKIT=1 docker build -t aml .
## docker run -d -it -p 8888:8888 -e PASSWORD=changeme -v ${PWD}/notebooks:/code --name lab aml

FROM python:3.8-slim

WORKDIR /code

COPY jupyter_notebook_config.py requirements.txt /etc/jupyter/
ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini /usr/local/bin/tini

RUN set -x \
  && pip install -U pip matplotlib notebook numpy openpyxl pandas scikit-learn scipy seaborn \
  && adduser jupyter \
  && chown -R jupyter:jupyter /code /etc/jupyter /home/jupyter \
  && chmod +x /usr/local/bin/* \
  && find / -name __pycache__ 2>/dev/null | xargs rm -r \
  && rm -rf /root/.[acpw]* /var/cache/apt/*

USER jupyter

EXPOSE 8888

ENTRYPOINT ["tini", "--"]

CMD ["jupyter", "notebook"]
