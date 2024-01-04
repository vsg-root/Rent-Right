import streamlit as st
from utils import load_data
from utils import clean_start

#Variáveis de teste:
clean = True    #Realiza iniciações limpas, serve para testar funcionamento do gerador de .csv (Deletando arquivos já existentes caso haja)

if clean:
    clean_start()
    clean = False

st.set_page_config(
    page_title = "Rent right",
    layout = "wide",
    menu_items = {
        'About': ''' Dashboard feito para a cadeira de PSI-3 do curso de sistemas de informação na UFRPE, feito por:
        - Alexandre Vital
        - Pedro Antunes
        - Vinícius Gomes
        - Vinícius Santos
        - Heitor Leony
        '''
    }
)
col1, col2 = st.columns([8, 1])
with col1:
    st.markdown(f'''<h1>Dashboard sobre o dataset "Housing"</h1>''', unsafe_allow_html=True)
with col2:
    st.image('assets\RentRightLogo.png')

st.markdown(f'''

    <br>
    Este dashboard tem a intenção de explorar e demonstrar as características do conjunto de dados 'Housing'
    , utilizado no sistema de previsão de preços de aluguel Rent Right, fornecendo informações relevantes sobre o mesmo
    <br>
    Dentro o dashboard possui as seguintes funções:
    <ul>
            <li>Análise descritiva dos dados.</li>
            <li>Filtragem do dataset.</li>
            <li>Agrupamento do dataframe.</li>
            <li>Profiling de dados.</li>
            <li>Clusterização dos dados</li>
            <li>Geração de mapa de calor</li>
            <li>Previsão de preço</li>
    </ul>
''', unsafe_allow_html=True)
