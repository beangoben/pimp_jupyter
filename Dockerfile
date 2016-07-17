FROM  jupyter/scipy-notebook

# make bash default shell
USER root
RUN ln -snf /bin/bash /bin/sh
# copy lato typography
COPY Lato /usr/share/fonts/truetype/

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

RUN jupyter nbextension enable usability/code_font_size/code_font_size
RUN jupyter nbextension enable usability/ruler/main
RUN jupyter nbextension enable styling/table_beautifier/main
RUN jupyter nbextension enable usability/codefolding/main
RUN jupyter nbextension enable usability/toggle_all_line_numbers/main
RUN jupyter nbextension enable usability/limit_output/main

#jupyter theme selector
RUN mkdir /opt/conda/share/jupyter/nbextensions/jupyter_themes &&\
    wget https://raw.githubusercontent.com/merqurio/jupyter_themes/master/theme_selector.js &&\
    mv theme_selector.js /opt/conda/share/jupyter/nbextensions/jupyter_themes &&\
    jupyter nbextension enable jupyter_themes/theme_selector

# live reveal
RUN git clone https://github.com/damianavila/RISE.git &&\
    cd RISE &&\
    python setup.py install &&\
    cd .. &&\
    rm -rf RISE

RUN sudo chown -R jovyan /home/jovyan/.jupyter

USER jovyan

#jupyter css
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY custom /home/jovyan/.jupyter/custom
