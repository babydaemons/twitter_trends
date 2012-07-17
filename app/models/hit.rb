class Hit < ActiveRecord::Base
  N = 20 # records / page

  def self.crawled
    find_by_sql("SELECT keyword_id, keyword, count\n" +
                "FROM (SELECT keyword_id, COUNT(keyword_id) as count FROM hits GROUP BY keyword_id) V\n" +
                "INNER JOIN keywords K ON K.id = V.keyword_id\n" +
                "ORDER BY K.id ASC")
  end

  def self.summary(from, span)
    timeslot = "TIMESTAMPDIFF(#{span}, created_at, :from)"
    find_by_sql(["SELECT #{timeslot} + 1 AS timeslot, COUNT(keyword_id) AS count, keyword_id FROM hits\n" +
                 "WHERE created_at BETWEEN TIMESTAMPADD(#{span}, -24, :from) AND :from\n" +
                 "GROUP BY #{timeslot}, keyword_id\n" +
                 "ORDER BY #{timeslot}, keyword_id\n",
                 {:from => from}])
  end

  def self.match(keyword_id, wanted, since, page)
    index1 = N * (page - 1) + 1
    index2 = N * page
    find_by_sql(["SELECT T.created_at, T.from_user, T.status_id, T.profile_image_url, T.text FROM tweets T\n" +
                 "INNER JOIN (\n" +
                 " SELECT status_id FROM hits WHERE created_at BETWEEN TIMESTAMPADD(HOUR, -24 * 7, :since) AND :since AND keyword_id = :keyword_id\n" +
                 ") V ON V.status_id = T.status_id\n" +
                 "WHERE T.text like :text\n" +
                 "ORDER BY T.created_at DESC\n" +
                 "LIMIT :index1, :index2",
                 {:keyword_id => keyword_id, :text => "%#{wanted}%", :since => since, :index1 => index1, :index2 => index2}])
  end

end
