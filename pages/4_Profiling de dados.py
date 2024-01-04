from ydata_profiling import ProfileReport
import streamlit.components.v1 as components
import streamlit as st
from utils import df_names, read_df, load_data, title
import os

#Data:
#https://raw.githubusercontent.com/datasciencedojo/datasets/master/titanic.csv
#http://dados.recife.pe.gov.br/dataset/acidentes-de-transito-com-e-sem-vitimas
#

def profile():
    df_path = "dataset/dataset.csv"
    df_name = "dataset"
    
    # Verifica se o diretório "reports" existe, se não, cria-o
    reports_dir = "reports"
    os.makedirs(reports_dir, exist_ok=True)

    if df_name in st.session_state:
        return 
    df = read_df(df_path)
    profile = ProfileReport(df, title=f"Dataset Report")
    
    # Salva o relatório no diretório "reports"
    report_path = os.path.join(reports_dir, f"{df_name}.html")
    profile.to_file(report_path)
    
    st.session_state[df_name] = df

def build_header():
    title("Profiling de dados")
    text ='''<p>Aqui você pode analizar e gerar diversos relatórios sobre os dados fornecidos pelo dataset, contando com uma sessão para cada uma das colunas do dataset</p>
    '''
    st.write(text, unsafe_allow_html=True)

def build_body():
    col1, col2 = st.columns([1,1])
    button_placeholder = col1.empty()
    if button_placeholder.button('Gerar relatório'):
        #O container 'col2.empty()' é utilizado para que se substitua o seu conteúdo.
        #Se usar o container diretamente, os conteúdos são adicionados ao invés de serem substituídos.
        button_placeholder.button('Analisando...', disabled=True)

        if os.path.exists(os.path.join('reports', 'dataset.html')):
            os.remove(os.path.join('reports', 'dataset.html'))
        profile()
        print_report()
        st.experimental_rerun()
        

def print_report():
    df_name = "dataset"
    #st.write(f'Dataset: <i>{df_name}</i>', unsafe_allow_html=True)
    report_file = open(f'reports/{df_name}.html', 'r', encoding='utf-8')
    source_code = report_file.read() 
    components.html(source_code, height=800, scrolling=True)

build_header()
build_body()
if os.path.exists(os.path.join('reports', 'dataset.html')):
    print_report()