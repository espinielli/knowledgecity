import csv
import re

# some of these could be regular expressions...
# for example 'source[s]?'
excluded = ['source', 'sources',
            'test', 'review',
            'business', 'dbt',
            'spec', 'cfmu', 'model']

categories = set()

with open('ABC20110101_20121001v1.csv', 'rb') as csvfile:
    scsreader = csv.DictReader(csvfile, delimiter=',', quotechar='"')
    # skip first row
    next(scsreader)
    for row in scsreader:
        #categories.add(row[15])
        c = set(row['Path'].split('/'))
        for p in excluded:
            for x in c:
                if not re.match(p, x):
                    categories.add(x)
