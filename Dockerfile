FROM  jupyter/scipy-notebook

# make bash default shell
USER root
RUN ln -snf /bin/bash /bin/sh

RUN conda update -y notebook
RUN conda update numpy scipy matplotlib seaborn
RUN conda clean --all

#jupyter theme selector
RUN mkdir /opt/conda/share/jupyter/nbextensions/jupyter_themes &&\
    wget https://raw.githubusercontent.com/merqurio/jupyter_themes/master/theme_selector.js &&\
    mv theme_selector.js /opt/conda/share/jupyter/nbextensions/jupyter_themes &&\
    jupyter nbextension enable jupyter_themes/theme_selector

# live reveal
RUN conda install -c damianavila82 -y rise

# jupyter notebook extensions
RUN conda install -y jupyter_nbextensions_configurator psutil
RUN jupyter nbextensions_configurator enable --system
RUN pip install yapf
RUN pip install https://github.com/ipython-contrib/jupyter_contrib_nbextensions/tarball/master
RUN jupyter contrib nbextension install --system
# update conda
RUN chown -R jovyan /home/jovyan
USER jovyan

RUN jupyter nbextension enable code_font_size/code_font_size
RUN jupyter nbextension enable ruler/main
RUN jupyter nbextension enable limit_output/main
RUN jupyter nbextension enable table_beautifier/main
RUN jupyter nbextension enable toggle_all_line_numbers/main
RUN jupyter nbextension enable code_prettify/code_prettify
RUN jupyter nbextension enable toc2/main
RUN jupyter nbextension enable css_selector/main

#jupyter css
RUN mkdir -p /home/jovyan/.jupyter/custom
COPY custom /home/jovyan/.jupyter/custom
