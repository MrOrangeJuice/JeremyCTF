/// @description Calculate Physics and Skin

key_left = 0;
key_right = 0;
key_jump = 0;


switch(skin)
{
	case "red":
		sprite_index = sRed;
		break;
	case "blue":
		sprite_index = sBlue;
		break;
	case "green":
		sprite_index = sGreen;
		break;
	case "yellow":
		sprite_index = sYellow;
		break;
	case "orange":
		sprite_index = sOrange;
		break;
	case "purple":
		sprite_index = sPurple;
		break;
}
	
// Get input depending on player slot
switch(player)
{
	case 0:
		key_left = keyboard_check(ord("A"));
		key_right = keyboard_check(ord("D"));
		key_jump = keyboard_check(vk_space);
		key_jump_released = keyboard_check_released(vk_space);
		break;
			
	case 1:
		if (gamepad_axis_value(0,gp_axislh) < -0.2 || gamepad_button_check(0,gp_padl) || gamepad_axis_value(4,gp_axislh) < -0.2 || gamepad_button_check(4,gp_padl))
		{
			key_left = 1;
		}

		if (gamepad_axis_value(0,gp_axislh) > 0.2 || gamepad_button_check(0,gp_padr) || gamepad_axis_value(4,gp_axislh) > 0.2 || gamepad_button_check(4,gp_padr))
		{
			key_right = 1;
		}

		if (gamepad_button_check(0,gp_face1) || gamepad_button_check(0,gp_shoulderr) || gamepad_button_check(4,gp_face1) || gamepad_button_check(4,gp_shoulderr))
		{
			key_jump = 1;
		}
		
		if (gamepad_button_check_released(0,gp_face1) || gamepad_button_check_released(0,gp_shoulderr) || gamepad_button_check_released(4,gp_face1) || gamepad_button_check_released(4,gp_shoulderr))
		{
			key_jump_released = 1;
		}
		break;
			
	case 2:
		if (gamepad_axis_value(1,gp_axislh) < -0.2 || gamepad_button_check(1,gp_padl) || gamepad_axis_value(5,gp_axislh) < -0.2 || gamepad_button_check(5,gp_padl))
		{
			key_left = 1;
		}

		if (gamepad_axis_value(1,gp_axislh) > 0.2 || gamepad_button_check(1,gp_padr) || gamepad_axis_value(5,gp_axislh) > 0.2 || gamepad_button_check(5,gp_padr))
		{
			key_right = 1;
		}

		if (gamepad_button_check(1,gp_face1) || gamepad_button_check(1,gp_shoulderr) || gamepad_button_check(5,gp_face1) || gamepad_button_check(5,gp_shoulderr))
		{
			key_jump = 1;
		}
		
		if (gamepad_button_check_released(1,gp_face1) || gamepad_button_check_released(1,gp_shoulderr) || gamepad_button_check_released(5,gp_face1) || gamepad_button_check_released(5,gp_shoulderr))
		{
			key_jump_released = 1;
		}
		break;
			
	case 3:
		if (gamepad_axis_value(2,gp_axislh) < -0.2 || gamepad_button_check(2,gp_padl) || gamepad_axis_value(6,gp_axislh) < -0.2 || gamepad_button_check(6,gp_padl))
		{
			key_left = 1;
		}

		if (gamepad_axis_value(2,gp_axislh) > 0.2 || gamepad_button_check(2,gp_padr) || gamepad_axis_value(6,gp_axislh) > 0.2 || gamepad_button_check(6,gp_padr))
		{
			key_right = 1;
		}

		if (gamepad_button_check(2,gp_face1) || gamepad_button_check(2,gp_shoulderr) || gamepad_button_check(6,gp_face1) || gamepad_button_check(6,gp_shoulderr))
		{
			key_jump = 1;
		}
		
		if (gamepad_button_check_released(2,gp_face1) || gamepad_button_check_released(2,gp_shoulderr) || gamepad_button_check_released(6,gp_face1) || gamepad_button_check_released(6,gp_shoulderr))
		{
			key_jump_released = 1;
		}
		break;
			
	case 4:
		if (gamepad_axis_value(3,gp_axislh) < -0.2 || gamepad_button_check(3,gp_padl) || gamepad_axis_value(7,gp_axislh) < -0.2 || gamepad_button_check(7,gp_padl))
		{
			key_left = 1;
		}

		if (gamepad_axis_value(3,gp_axislh) > 0.2 || gamepad_button_check(3,gp_padr) || gamepad_axis_value(7,gp_axislh) > 0.2 || gamepad_button_check(7,gp_padr))
		{
			key_right = 1;
		}

		if (gamepad_button_check(3,gp_face1) || gamepad_button_check(3,gp_shoulderr) || gamepad_button_check(7,gp_face1) || gamepad_button_check(7,gp_shoulderr))
		{
			key_jump = 1;
		}
		
		if (gamepad_button_check_released(3,gp_face1) || gamepad_button_check_released(3,gp_shoulderr) || gamepad_button_check_released(7,gp_face1) || gamepad_button_check_released(7,gp_shoulderr))
		{
			key_jump_released = 1;
		}
		break;
}
			
// Calculate Physics
		
var move = key_right - key_left;

hsp = move * walksp;

vsp = vsp + grv;
		
// Jumping
if (place_meeting(x,y+1,oWall)) && (key_jump)
{
	vsp = -20;
}

// Variable jump height
if vsp < 0 && (!(key_jump)) //if you're moving upwards in the air but not holding down jump
{
	vsp *= 0.85; //essentially, divide your vertical speed
}
		
// Horizontal Collision
if (place_meeting(x+hsp,y,oWall))
{
	while (!place_meeting(x+sign(hsp),y,oWall))
	{
		x = x + sign(hsp);
	}
	hsp = 0;
}

x = x + hsp;

// Vertical Collision
if (place_meeting(x,y+vsp,oWall))
{
	while (!place_meeting(x,y+sign(vsp),oWall))
	{
		y = y + sign(vsp);
	}
	vsp = 0;
}

y = y + vsp;