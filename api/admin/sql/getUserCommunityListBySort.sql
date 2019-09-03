with users as (
    select 
        id, government_uri, username, "createdAt", community_user.disabled, is_manager, agency_id, last_login, name,
        coalesce(given_name, (string_to_array(trim(name), ' '))[array_lower(string_to_array(trim(name), ' '), 1)]) as given_name,
		coalesce(last_name, (string_to_array(trim(name), ' '))[array_upper(string_to_array(trim(name), ' '), 1)]) as last_name, 
        (
			select row_to_json (agency)
			from (
				select * from agency where midas_user.agency_id = agency.agency_id
			) agency
		) as agency
    from midas_user inner join community_user on midas_user.id = community_user.user_id
    where midas_user.disabled = 'f' and community_user.community_id = ? 
)

select count(*) over() as full_count, * from users
[where clause]
order by [order by]
limit 25 offset ((? - 1) * 25);