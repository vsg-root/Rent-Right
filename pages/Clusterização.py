import streamlit as st
from modules.data_loader import load_data
from sklearn.cluster import KMeans
import seaborn as sns
import matplotlib.pyplot as plt

df = load_data("dataset\housing.parquet")  # Caminho atualizado
st.subheader("Clusterização de Imóveis")


features = st.multiselect("Selecione as características para a clusterização", df.columns, default=['price', 'sqfeet'])

if st.button("Realizar Clusterização"):
    
    k = st.slider("Escolha o número de clusters", 2, 10, 3)
    kmeans = KMeans(n_clusters=k)
    df['cluster'] = kmeans.fit_predict(df[features])

    
    st.write("Visualização dos Clusters")
    sns.scatterplot(data=df, x=features[0], y=features[1], hue='cluster', palette='viridis')
    st.pyplot(plt)