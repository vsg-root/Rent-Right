import streamlit as st
from utils import df_names, read_df, title

def build_header():
    title("Agrupamento do Dataframe")
    text ='''<h1></h1>
    <p> Aqui você pode escolher métodos de agrupamentos para usar no dataset, com cada método alterando os possíveis resultados, as tabelas geradas pela forma de agrupamento
    serã exibidas abaixo '''
    st.write(text, unsafe_allow_html=True)
    
def build_body():
    col1, col2 = st.columns([.3,.7])
    df_name = col1.selectbox('Dataset', df_names())
    df = read_df(df_name)
    cols = list(df.columns)
    group_cols = col2.multiselect('Agrupar', options=cols, default=cols[0])
    tot_opts = [x for x in cols if x not in group_cols]
    tot_fun = col1.selectbox('Função', options=['count','nunique','sum','mean'])
    tot_cols = col2.multiselect('Totalizar', options=tot_opts, default=tot_opts[0])
    select_cols = tot_cols+group_cols
    df_grouped = df[select_cols].groupby(by=group_cols).agg(tot_fun)
    st.write('Data frame:')
    st.dataframe(df_grouped, use_container_width=True)

build_header()
build_body()
