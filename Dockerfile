FROM  jupyter/scipy-notebook

# make bash default shell
USER root
RUN ln -snf /bin/bash /bin/sh

RUN apt-get update && \
    apt-get install -y jq && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN conda update -y -q notebook
RUN conda install -y -q conda-build
RUN conda update -y -q numpy scipy matplotlib seaborn
RUN conda clean --all

#jupyter theme selector
RUN mkdir /opt/conda/share/jupyter/nbextensions/jupyter_themes &&\
    wget https://raw.githubusercontent.com/merqurio/jupyter_themes/master/theme_selector.js &&\
    mv theme_selector.js /opt/conda/share/jupyter/nbextensions/jupyter_themes &&\
    jupyter nbextension enable jupyter_themes/theme_selector

# live reveal
RUN conda install -y -q -c damianavila82 rise

# jupyter notebook extensions
RUN conda install -y -q -c conda-forge jupyter_contrib_nbextensions yapf
RUN conda install -y -q -c conda-forge -n python2 yapf

#RUN conda install -y jupyter_nbextensions_configurator psutil
RUN jupyter nbextensions_configurator enable --system
RUN jupyter contrib nbextension install --system
# update conda
RUN chown -R $NB_USER /home/$NB_USER
USER $NB_USER

RUN jupyter nbextension enable code_font_size/code_font_size
RUN jupyter nbextension enable ruler/main
#RUN jupyter nbextension enable limit_output/main
RUN jupyter nbextension enable table_beautifier/main
RUN jupyter nbextension enable toggle_all_line_numbers/main
RUN jupyter nbextension enable code_prettify/code_prettify
RUN jupyter nbextension enable toc2/main
#RUN jupyter nbextension enable css_selector/main
# load default extension options
COPY nbextensions_default.json /home/$NB_USER/.jupyter/nbconfig
RUN cd /home/$NB_USER/.jupyter/nbconfig && jq -s add notebook.json nbextensions_default.json > new.json && mv new.json notebook.json
#jupyter css
RUN mkdir -p /home/$NB_USER/.jupyter/custom
COPY custom /home/$NB_USER/.jupyter/custom
