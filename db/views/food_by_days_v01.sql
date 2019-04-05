select MAX(id) as id, user_id, color, date, COUNT(color) as color_count
from foods
group by user_id, color, date