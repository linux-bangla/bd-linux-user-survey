<h1>লিনাক্স ব্যবহারকারী জরিপ ২০২৫ এর ফলাফল</h1>

Files:
<br/>
`public/index.html` -> This one shows the results via embedded survey data (Best approach without any api dependency)
<br/>
<br/>
`index_.html` -> This one shows the results by loading the csv each time (Inefficient approach, so unused)
<br/>
<br/>
`public/survey_results_2025.csv` -> The manually processed survey data. Some data had multiple entries. Sperated them by ";" and added to the individual values.
<br/>
<br/>
`csv_to_chart.py` -> Generates chart data from the raw csv that we use in the website.

<h4>To get the results data as chart data:</h2> 
At first,

```
python3 csv_to_chart.py survey_results_2025.csv > chart_data.json
```
Then, to get in single compact string,
```
python3 csv_to_chart.py survey_results_2025.csv | jq -c .
```

<br/>
For running locally:

```
python3 -m http.server 
```
<br/>

∞