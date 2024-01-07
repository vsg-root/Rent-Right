import streamlit as st
from utils import load_data, title
from sklearn.cluster import KMeans
import seaborn as sns
import matplotlib.pyplot as plt

df = load_data()  # Caminho atualizado
title("Clusterização")

text ='''<p>Aqui você pode testar gerações de clusters a partir dos parâmetro que você escolheu, um gráfico então será gerado e exibido logo abaixo</p>'''
st.write(text, unsafe_allow_html=True)

features = st.multiselect("Selecione as características para a clusterização", df.columns, default=['price', 'sqfeet'])
k = st.slider("Escolha o número de clusters", 2, 10, 3)

if st.button("Realizar Clusterização"):
    kmeans = KMeans(n_clusters=k)
    df['cluster'] = kmeans.fit_predict(df[features])
    st.write("Visualização dos Clusters:")
    sns.scatterplot(data=df, x=features[0], y=features[1], hue='cluster', palette='viridis')
    st.pyplot(plt)