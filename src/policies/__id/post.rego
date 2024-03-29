package peoplefinder.POST.api.users.__id

default allowed = false

default visible = true

default enabled = false

## 0.0.11

allowed {
	props = input.user.properties
	props.department == "Operations"
}

allowed {
	is_manager_of(input.user.id, input.resource.id)
}

enabled {
	allowed
}

## Use the ReBAC check_relation built-in to determine 
## whether the current user is the manager of the target user
is_manager_of(current_user_id, target_user_id) {
	ds.check_relation({
		"object": {"id": current_user_id},
		"relation": {
			"object_type": "user",
			"name": "manager",
		},
		"subject": {"id": target_user_id},
	})
}
