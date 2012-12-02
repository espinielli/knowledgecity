import re
# categ is a dictionary of domains
# with associated list of keywords (or regular expressions)
categ = {
  'DOM+': ['dom', 'tape'],
  'AS':   ['[Aa]irspace?', 'rsa'],
  'FUA':  ['[Cc]iam', '([aA]|[uU])up', 'AUP', 'UUP', 'RSA']
}

def classify(listOfTopics):
    """Return an array of domains matched by listOfTopics."""
    result = []

    def catForTop(regexes, topic):
        for pattern in regexes:
            if re.match(pattern, topic):
                return True
        return False

    for category, regexes in categ.iteritems():
        for topic in listOfTopics:
            if catForTop(regexes, topic):
                result.append(category)
    return result
