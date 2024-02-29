import pandas as pd
import plotly.graph_objs as go
from sklearn.cluster import KMeans
from sklearn.preprocessing import StandardScaler


model_input_data = pd.read_csv('model_input_data.csv')

X = model_input_data[['lat', 'long', 'price']]

scaler = StandardScaler()
X_scaled = scaler.fit_transform(X)

def plot_usa_clusters(num_clusters: int):

    kmeans = KMeans(n_clusters=num_clusters, random_state=42)
    cluster_labels = kmeans.fit_predict(X_scaled)

    model_input_data['Cluster'] = cluster_labels

    fig = go.Figure()

    for cluster in range(num_clusters):
        cluster_data = model_input_data[model_input_data['Cluster'] == cluster]
        fig.add_trace(go.Scattergeo(
            lon = cluster_data['long'],
            lat = cluster_data['lat'],
            text = cluster_data['price'].astype(str) + ' USD',
            mode = 'markers',
            marker = dict(
                size = 8,
                opacity = 0.8,
                color = cluster,
                colorscale = 'Rainbow',
                line = dict(width=0.5, color='white')
            ),
            name = f'Cluster {cluster}'
        ))

    fig.update_layout(
        title = f'Mapa dos EUA com {num_clusters} clusters',
        geo = dict(
            scope = 'usa',
            projection_type = 'albers usa',
            showland = True,
            landcolor = 'rgb(217, 217, 217)',
            subunitwidth=1,
            countrywidth=1,
            subunitcolor="rgb(255, 255, 255)",
            countrycolor="rgb(255, 255, 255)"
        ),
    )

    fig.show()

def cluster_analysis(model_input_data, num_clusters):

    kmeans = KMeans(n_clusters=num_clusters, random_state=42)
    cluster_labels = kmeans.fit_predict(X_scaled)

    model_input_data['Cluster'] = cluster_labels

    cluster_data_dict = {}

    for cluster in range(num_clusters):
        cluster_data = model_input_data[model_input_data['Cluster'] == cluster]
        cluster_data_dict[f'Cluster {cluster}'] = cluster_data

    for cluster, data in cluster_data_dict.items():
        print(f"\nAnálise descritiva para {cluster}:")
        print(data.describe())

# cluster_analysis(model_input_data, 5)

plot_usa_clusters(5)  
