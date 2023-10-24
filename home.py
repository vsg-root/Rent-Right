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
  
    <p>Desenvolvedores: Alexandre Neiva Vital, Heitor Leonny, Pedro Antunes, Vinicius Ferraz, Vinicius Santos e Vinicius Gomes.</p>
    <p>No contexto do mercado imobiliário, existe uma crescente necessidade de transparência e eficiência na precificação de aluguéis. Atualmente, inquilinos e proprietários enfrentam desafios para determinar valores justos, muitas vezes levando a discrepâncias e insatisfações. O RentRight é um sistema que emprega machine learning para predizer com precisão os valores de aluguéis nos Estados Unidos, considerando variáveis complexas que influenciam os preços. Este projeto surge como uma solução para as ineficiências atuais do mercado, proporcionando uma plataforma confiável para estimativas de aluguel. 
    O RentRight desenvolverá um modelo preditivo robusto utilizando um conjunto de dados compreensivo do Kaggle, o sistema irá incorporar múltiplos fatores para fornecer estimativas de aluguel precisas e confiáveis. Através de uma interface de usuário intuitiva permitirá que usuários insiram detalhes da propriedade e obtenham estimativas instantâneas do valor do aluguel. Melhorando a satisfação do cliente no processo de locação ao estabelecer uma metodologia transparente e confiável para a avaliação de propriedades, o RentRight visa aumentar a confiança e satisfação entre inquilinos e proprietários.
    Embora ainda esteja em suas fases iniciais, o RentRight promete ser uma ferramenta revolucionária no mercado imobiliário. Ao alavancar tecnologias avançadas e análises precisas, tem o potencial de transformar a maneira como os aluguéis são avaliados e negociados, beneficiando uma ampla gama de stakeholders.
    </p>
    <h2>Consulta de dados</h2>
''', unsafe_allow_html=True)


dados = pd.read_csv('dataset\housing.csv')



coluna_selecionada = st.selectbox("Selecione a coluna para ordenar:", dados.columns)
ordem_ordenacao = st.radio("Selecione a ordem de ordenação:", ("Ascendente", "Descendente"))


ascending = True if ordem_ordenacao == "Ascendente" else False


dados_ordenados = dados.sort_values(by=coluna_selecionada, ascending=ascending)


dados_ordenados = dados_ordenados.head(10)


st.write("Primeiros 10 registros ordenados:")
st.write(dados_ordenados)


st.bar_chart(dados_ordenados[coluna_selecionada])







