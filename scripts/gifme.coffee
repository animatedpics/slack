module.exports = (robot) ->
  robot.hear /gifme (\w+)/i, (res) ->
    link = res.match[1]
    robot.http("http://search.gif.gallery/gifs/gif/_search?q=" + link)
      .get() (err, resp, body) ->
        data = JSON.parse(body)
        if data and data['hits'] and data['hits']['total'] and data['hits']['total'] > 0
          randomNumAlt = Math.floor(Math.random() * (data['hits']['total'] - 0))
          if data['hits']['hits'][randomNumAlt] and data['hits']['hits'][randomNumAlt]['_source'] and data['hits']['hits'][randomNumAlt]['_source']['url']
            res.send data['hits']['hits'][randomNumAlt]['_source']['url']
          else
            res.send "Cannot find"
        else
          res.send "Cannot find"