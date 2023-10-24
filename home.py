import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
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
    <h2>RentRight: Optimizing Rental Predictions through Machine Learning</h2>
''', unsafe_allow_html=True)


header = st.container()


    
image = st.image('assets\Logo_Rent_new_Git.png', width= 700)
st.text('Presented by Ferraz, Alexandre, Gomes, Santos, Pedro, Heitor ')


    
    


dados = pd.read_csv('dataset\housing.csv')


# opções para o usuário escolher
st.markdown(
    '<h3>Query by filters</h3>',
    unsafe_allow_html=True)
coluna_selecionada = st.selectbox("Selecione a coluna para ordenar:", dados.columns)
ordem_ordenacao = st.radio("Selecione a ordem de ordenação:", ("Crescente", "Decrescente"))


ascending = True if ordem_ordenacao == "Crescente" else False


dados_ordenados = dados.sort_values(by=coluna_selecionada, ascending=ascending)

numero_mostrado = st.radio('Quantidade a ser mostrada: ', ('10', '20', '50', '100'))
dados_ordenados = dados_ordenados.dropna()
dados_ordenados = dados_ordenados.head(int(numero_mostrado))


st.write(f"Primeiros {numero_mostrado} registros ordenados de forma {ordem_ordenacao.lower()}: ")

# tabela
st.markdown(
    '<h3>Table</h3>',
    unsafe_allow_html=True)
st.write(dados_ordenados)

# gráfico
st.markdown(
    '<h3>Bar chart</h3>',
    unsafe_allow_html=True)
st.bar_chart(dados_ordenados[coluna_selecionada])



# mapa
st.markdown(
    '<h3>Map</h3>',
    unsafe_allow_html=True)
m = folium.Map(location=[dados_ordenados['lat'].mean(), dados_ordenados['long'].mean()], zoom_start=10)


for index, row in dados_ordenados.iterrows():
    folium.Marker([row['lat'], row['long']]).add_to(m)

mapa_html = 'mapa_temp.html'
m.save(mapa_html)


st.components.v1.html(open(mapa_html).read(), width=700, height=500)