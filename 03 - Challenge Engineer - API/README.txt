>>>> Cómo ejecutar el script:

Existen diversas alternativas para la ejecución del Script en Python para consumir API de cotizaciones y extraer la información en un archivo plano csv. Se pueden utilizar las siguientes aplicaciones:

* Visual Studio Code
* Jupiter Notebook
* Terminal (Mac: Ejecutar código: python3.10 Extraccion_moneda.py)
* Crear un ETL en DataSuite con DataFlow para Python

Archivos:

- Script_Extraccion_moneda (Script Python de extracción de datos)
- Extraccion_moneda_BD (Idem pero con inserción en base de datos mysql - Jupyter Notebook)
- Extraccion_moneda (Idem pero con extracción de ultima cotización para las 3 monedas USD/BRL-EUR/BRL-BTC/BRL)
- Extraccion_moneda_Fechas (Idem al primer Script pero con el paso a paso en Jupyter Notebook)



>>>> Cómo se estructuran los datos:

>> moeda_base
>> moeda_destino
>> valor_compra
>> valor_venda
>> data_hora (normalizada para o formato UTC: yyyy-MM-dd HH:mm:ss)



>>>> Tecnologías utilizadas:

* Visual Studio Code (Python)
* Jupyter Notebook (Python)
* DB mysql (Sql)
* Docker Desktop