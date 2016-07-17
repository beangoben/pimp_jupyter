FROM  jupyter/scipy-notebook

USER jovyan
#jupyter theme selector
RUN mkdir /opt/conda/share/jupyter/nbextensions/jupyter_themes
RUN wget https://raw.githubusercontent.com/merqurio/jupyter_themes/master/theme_selector.js
RUN mv theme_selector.js /opt/conda/share/jupyter/nbextensions/jupyter_themes
RUN  jupyter nbextension enable jupyter_themes/theme_selector
#jupyter css
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY custom /home/jovyan/.jupyter/custom

USER root
# copy lato typography
RUN mv /home/jovyan/.jupyter/custom/Lato /usr/share/fonts/truetype/

# jupyter notebook extensions
RUN pip install jupyter_nbextensions_configurator psutil

RUN JUPYTER_DATA_DIR=/usr/local/share/jupyter &&\
    JUPYTER_CONFIG_DIR=/usr/local/share/jupyter &&\
    git clone https://github.com/ipython-contrib/IPython-notebook-extensions.git &&\
    cd IPython-notebook-extensions &&\
    python setup.py install &&\
    cd .. &&\
    rm -rf IPython-notebook-extensions
# enable some extensions by default





USER jovyan

