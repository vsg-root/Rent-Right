import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import zipfile
import folium
st.set_page_config(
    page_title = 'Dasboard Rent Right',
    layout = 'wide',
    menu_items = {
        'About': '''Esse projeto foi desenvolvido pelos alunos Alexandre, Heitor, Pedro, Vinivius Ferraz, Vinicius Santos e Vinicius Gomes.'''
    }
)

st.markdown(f'''
    <h1>PSI3</h1>
    <h2>RentRight: Otimização de Predições de Aluguel através de Machine Learning</h2>
''', unsafe_allow_html=True)


header = st.container()
dataset = st.container()


with header:
    st.title('Welcome to Rent Right')
    image = st.image('assets\Logo_Rent_new_Git.png', width= 700)
    st.text('Presented by Ferraz, Alexandre, Gomes, Santos, Pedro, Heitor ')


    
    
st.title('USA national rent Database')
st.write(
        "<p>This text was extracted from Craigslist, world's greatest descentralized marketplace. It has more than 20 collumns and more than 300k houses.</p>",
        unsafe_allow_html=True)

dados = pd.read_csv('dataset\housing.csv')



coluna_selecionada = st.selectbox("Selecione a coluna para ordenar:", dados.columns)
ordem_ordenacao = st.radio("Selecione a ordem de ordenação:", ("Crescente", "Decrescente"))


ascending = True if ordem_ordenacao == "Crescente" else False


dados_ordenados = dados.sort_values(by=coluna_selecionada, ascending=ascending)


dados_ordenados = dados_ordenados.head(20)


st.write(f"Primeiros 20 registros ordenados de forma {ordem_ordenacao.lower()}: ")
st.write(dados_ordenados)


st.bar_chart(dados_ordenados[coluna_selecionada])







