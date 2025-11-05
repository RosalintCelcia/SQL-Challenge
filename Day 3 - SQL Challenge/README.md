🗓️ 21 𝐃𝐚𝐲𝐬 𝐒𝐐𝐋 𝐂𝐡𝐚𝐥𝐥𝐞𝐧𝐠𝐞 - 𝐃𝐚𝐲 3: 𝐒𝐨𝐫𝐭𝐢𝐧𝐠 𝐰𝐢𝐭𝐡 𝐎𝐑𝐃𝐄𝐑 𝐁𝐘 𝐂𝐥𝐚𝐮𝐬𝐞 🔽🔼

Keeping the SQL momentum strong! 🚀
Today, I learned how to sort query results for clearer insights using the ORDER BY clause.

📘 Daily Challenge:

Question:
Retrieve the top 5 weeks with the highest patient refusals across all services, showing:
week, service, patients_refused, and patients_request.
Sort the results by patients_refused in descending order.

🧩 𝐐𝐮𝐞𝐫𝐲 𝐔𝐬𝐞𝐝
SELECT 
  week,
  service,
  patients_refused,
  patients_request
FROM services_weekly
ORDER BY patients_refused DESC
LIMIT 5;

🔍 𝐐𝐮𝐞𝐫𝐲 𝐁𝐫𝐞𝐚𝐤𝐝𝐨𝐰𝐧

🔹 The query picks four useful fields — week, service, patients_refused, and patients_request — to focus on refusal performance.
🔹 ORDER BY sorts the data by patients_refused in descending order, showing the weeks with the highest refusal counts first.
🔹 LIMIT 5 restricts the output to only the top 5 critical weeks.
🔹 This approach highlights performance issues quickly and helps prioritize improvements.

💡 𝐊𝐞𝐲 𝐋𝐞𝐚𝐫𝐧𝐢𝐧𝐠𝐬

ORDER BY sorts query results based on one or more columns.

Sorting can be done in ASC (ascending) or DESC (descending) order.

ASC is the default order if not specified.

You can sort by multiple columns, and their order affects the final result.

Columns used in ORDER BY don’t need to appear in SELECT.

DESC is useful for “Top-N” queries (e.g., top customers, highest scores).

ORDER BY usually appears at the end of a query (before LIMIT).

✨ Thanks to Indian Data Club & DPDzero for this amazing learning initiative! 🙌
