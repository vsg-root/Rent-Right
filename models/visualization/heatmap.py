import pandas as pd
import plotly.express as px

class HeatmapVisualizer:
    def __init__(self, data_file):
        self.data = pd.read_csv(data_file)

    def generate_heatmap(self):
        fig = px.density_mapbox(self.data,
                                lat='lat',
                                lon='long',
                                z='price',
                                radius=10,
                                center=dict(lat=37.0902, lon=-95.7129),
                                zoom=3,
                                mapbox_style="stamen-terrain",
                                title='Mapa de Calor de Preços de Propriedades nos EUA')
        return fig

    def show_heatmap(self):
        fig = self.generate_heatmap()
        fig.show()

heatmap_visualizer = HeatmapVisualizer('model_input_data.csv')
heatmap_visualizer.show_heatmap()
