WITH all_ids AS (
    SELECT ra.requester_id AS id, COUNT(*) AS cnt
    FROM RequestAccepted ra
    GROUP BY ra.requester_id

    UNION ALL 

    SELECT ra.accepter_id AS id, COUNT(*) AS cnt 
    FROM RequestAccepted ra
    GROUP BY ra.accepter_id
)

SELECT id, SUM(cnt) AS num
FROM all_ids
GROUP BY id
ORDER BY num DESC
LIMIT 1
