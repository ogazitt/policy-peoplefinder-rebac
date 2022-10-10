package peoplefinder.POST.api.users.__id

default allowed = false

default visible = true

default enabled = false

allowed {
	props = input.user.attributes.properties
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
## 0.0.8
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
