import random
# parameters
category = 0
coursename = "C1"
tags = "@block @block_evasys_sync @block_evasys_sync_fulltest"
feature_desc = "Tests all use-cases of the Evasys-block"
# catoptions
automode = ["manual", "auto"]
standardtimemode = [0, 1]
# courseoptions
students = ["none", "onlytutors", "multi"]
idnumber = ["none", "invalid", "one"]
mapped = ["none", "invalid", "one", "multi"]
internalstate = ["notopened", "opened", "closed", "manual", "none"]
actualstate = ["open", "closed", "mixed"]
# dicts

students_descriptions = {
	"none": "If there are no students I should see a warning\n",
	"onlytutors": "If there are only tutors I should see a warning\n",
	"multi": ""
}

standardtimemode_descriptions = {
	0: "If there is no standardtimemode I should not see the option to use it\n",
	1: "If there is a standartimemode I should see the option to use it\n"
}

idnumber_descriptions = {
	"none": "",
	"invalid": "If there is an invalid idnumber I should see a warning\n",
	"one": "If there is an idnumber I should see this evasys-course\n"
}

mapped_descriptions = {
	"none": "",
	"invalid": "If there are invalid mappings I should see a warning\n",
	"one": "If there is a course mapped I should see this evasys-course\n",
	"multi": "If there are multiple courses mapped I should see all of those\n"
}

manual_auto_mode = {
	"manual": "Given category {{category}} is in manual mode",
	"auto": "Given category {{category}} is in auto mode"
}

standardtimeMode = {
	0: "And category {{category}} is not in standardtime mode",
	1: "And category {{category}} is in standardtime mode"
}

internalState = {
	"notopened": "And the internal state of course {{course}} is \"notopened\"",
	"opened": "And the internal state of course {{course}} is \"opened\"",
	"closed": "And the internal state of course {{course}} is \"closed\"",
	"manual": "And the internal state of course {{course}} is \"manual\"",
	"none": "And there is no internal record of course {{course}}"
}

studentsState = {
	"none": "And no students enrolled in course " + coursename,
	"onlytutors": "And only tutors enrolled in course " + coursename,
	"multi": "And students enrolled in course " + coursename
}

inconsistent_mode = "Then I should see \"This evaluation was already started in another mode\""

automode_checks = {
	"manual": "And I should see \"Request evaluation\"",
	"auto": 'And I should see "Set evaluation period"'
}

standardtimemode_checks = {
	0: "And I should not see \"Offer standard period of time\"",
	1: 'And I should see "Offer standard period of time"'
}

student_checks = {
	"none": "And I should see \"This course does not contain any students that can evaluate it.\"\n",
	"onlytutors": 'And I should see \"This course contains only tutors\"\n',
	"multi": ""
}

idnumber_checks = {
	"none": "",
	"invalid": "Then I should see \"The lsf-course linked to this course is invalid\"\n",
	"one": ""
}

mapped_checks = {
	"none": "",
	"invalid": "Then I should see \"One of the associated lsf-courses is invalid\"\n",
	"one": "",
	"multi": ""
}

internal_state_checks = {
	"notopened": "And I should see \"Evaluationperiod has been set\"\n",
	"opened": "And the startselector should be disabled\n",
	"closed": "And both selectors should be disabled\n",
	"manual": "And I should see \"Evaluation has been requested\"\n",
	"none": ""
}

background = '  Background:\n\
    Given the following "users" exist:\n\
      | username | firstname | lastname | email |\n\
      | teacher1 | Teacher | 1 | teacher1@example.com |\n\
	  | student1 | Student | 1 | student1@example.com |\n\
    And the following "courses" exist:\n\
      | fullname | shortname | category |\n\
      | Course 1 | C1 | 0 |\n\
    And the following "course enrolments" exist:\n\
      | user | course | role |\n\
      | teacher1 | C1 | editingteacher |\n\
    And I log in as "teacher1"\n\
    And I am on "Course 1" course homepage'

# other shorthands
def evasys_relations(shortname, idnumber, semestertxt, veranstnr):
	x = "And The following Evasys relations exist: \n" \
		"  | shortname | idnumber | semestertxt | veranstnr |\n"
	for i in range(0, len(shortname)):
		x += "  | " + shortname[i] + " | " + idnumber[i] + " | " + semestertxt[i] + " | " + veranstnr[i] + " |\n"
	return x


def evasys_courses(evasysid, title, studentcount):
	x = "And The following evasys courses exist: \n" \
	    "  | evasysid | title  | studentcount |\n"
	for i in range(0, len(evasysid)):
		x += "  | " + evasysid[i] + " | " + title[i] + " | " + studentcount[i] + " |\n"
	return x


def evasys_forms(formid):
	x = "And The following Forms exist: \n" \
	    "  | id | name  | title |\n"
	for i in range(0, len(formid)):
		x += "  | " + str(formid[i]) + " | " + "AAAA" + str(formid[i]) + " | " + "Testformnr. " + str(formid[i]) + " |\n"
	return x


def evasys_surveys(evasys_course, title, formid, open, completed=-1):
	x = "And The following surveys exist: \n" \
	    "  | course | title  | formid | open | completed |\n"
	for i in range(0, len(evasys_course)):
		if not isinstance(completed, list):
			x += "  | " + str(evasys_course[i]) + " | " + str(title[i]) + " | " + str(formid[i]) + " | " + str(open[i]) + " | " + str(random.randrange(200) + 1) + " |\n"
		else:
			x += "  | " + str(evasys_course[i]) + " | " + str(title[i]) + " | " + str(formid[i]) + " | " + str(open[i]) + " | " + str(completed[i]) + " |\n"
	return x


def lsf_evasys_surveys (courseshortname, lsfcourses, semsestertxt, veranstnr):
	x = "And the course with shortname " + str(courseshortname) + " has the following lsfcourses mapped:\n" \
		"  | lsfcourse | semestertxt | veranstnr |\n"
	for i in range(0, len(lsfcourses)):
		x += "  | " + lsfcourses[i] + " | " + semsestertxt[i] + " | " + veranstnr[i] + " |\n"
	return x


lsfcourseid = 0
def idnumberState (state):
	global lsfcourseid
	if state == "none":
		return "And there is no idnumber mapped to course " + coursename + "\n"
	elif state == "invalid":
		return "And the idnumber for course " + coursename + " is invalid\n"
	elif state == "one":
		x = evasys_relations([coursename], [str(lsfcourseid)], ["WS 2018/19"], [str(lsfcourseid)])
		lsfcourseid += 1
		return x


def mappedState (state):
	global lsfcourseid
	if state == "none":
		return "And no courses are mapped to course " + coursename + "\n"
	elif state == "invalid":
		return "And only invalid mappings are present for course " + coursename + "\n"
	elif state == "one":
		x = lsf_evasys_surveys(coursename, [str(lsfcourseid)], ["WS 2018/19"], [str(lsfcourseid)])
		lsfcourseid += 1
		return x
	elif state == "multi":
		lsfcourses = [str(lsfcourseid), str(lsfcourseid + 1)]
		veranstnr = [str(lsfcourseid), str(lsfcourseid + 1)]
		x = lsf_evasys_surveys(coursename, lsfcourses, ["WS 2018/19"] * 2, veranstnr)
		lsfcourseid += 2
		return x


def makeEvasysSurveys (state):
	global lsfcourseid
	if state == "mixed" and lsfcourseid < 2:
		return ""
	coursenames = [] * lsfcourseid
	titles = [] * lsfcourseid
	for i in range(0, lsfcourseid):
		coursenames.append(str(i) + " WS 2018/19 ")
		titles.append("Survey " + str(i))
	if state == "open":
		status = [1] * lsfcourseid
	elif state == "closed":
		status = [0] * lsfcourseid
	else:
		status = [0, 1] + [0] * lsfcourseid
	return evasys_surveys(coursenames, titles, [1] * lsfcourseid, status)





def get_checks(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
	checks = ""
	if (idnumber_state == "none" or idnumber_state == "invalid") and (mapped_state == "none" or mapped_state == "invalid"):
		return "Then I should see \"Change mapping\"\nAnd I should not see \"Name:\"\n"

	checks += "And I press \"Show status of surveys\"\n"
	checks += idnumber_checks[idnumber_state]
	checks += mapped_checks[mapped_state]
	if ((internal_state != "manual" and internal_state != "none") and mode == "manual") or (internal_state == "manual" and mode == "auto"):
		checks += inconsistent_mode + "\n"
	else:
		checks += internal_state_checks[internal_state]
		if internal_state == "none" or (internal_state == "notopened" and mode == "auto"):
			checks += automode_checks[mode] + "\n"

	if internal_state == "closed" and actual_state != "closed":
		checks += "And I should see \"There are some open surveys, but all surveys should be closed.\"" + "\n"
	elif internal_state != "closed" and actual_state != "open":
		checks += "And I should see \"Some of the surveys have been closed ahead of schedule!\"" + "\n"
	checks += standardtimemode_checks[standardtime] + "\n"
	checks += student_checks[students_state]
	return checks


def get_description(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
	if (mapped_state == "none" or mapped_state == "invalid") and (idnumber_state == "none" or idnumber_state == "invalid"):
		return "If there are no related evasys-courses I should not see any.\n    "
	description = ""
	description += standardtimemode_descriptions[standardtime]
	description += students_descriptions[students_state]
	description += idnumber_descriptions[idnumber_state]
	description += mapped_descriptions[mapped_state]
	if ((internal_state != "manual" or internal_state != "none") and mode == "manual") or (internal_state == "manual" and mode != "manual"):
		description += "If there are inconsistent modes I should see a warning\n"
	if (actual_state != "open" and internal_state == "opened") or (internal_state == "closed" and actual_state != "closed"):
		description += "If there are surveys that don't match the internal state I should see a warning\n"
	description = description.replace("\n", "\n    ")
	return description


def make_scenario(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
	global lsfcourseid
	lsfcourseid = 0
	behat_scenario = manual_auto_mode[mode].replace("{{category}}", str(category)) + "\n"
	behat_scenario += standardtimeMode[standardtime].replace("{{category}}", str(category)) + "\n"
	behat_scenario += studentsState[students_state] + "\n"
	behat_scenario += idnumberState(idnumber_state)
	behat_scenario += mappedState(mapped_state)
	behat_scenario += evasys_forms([1])
	behat_scenario += internalState[internal_state].replace("{{course}}", str(coursename)) + "\n"
	behat_scenario += makeEvasysSurveys(actual_state)

	behat_scenario += "And I turn editing mode on\n"
	behat_scenario += "And I add the \"EvaSys Sync\" block\n"
	behat_scenario += "And I turn editing mode off\n"
	behat_scenario += get_checks(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state)
	behat_scenario = behat_scenario.replace("\n", "\n    ")
	if actual_state == "mixed" and lsfcourseid < 2:
		return ""
	return "  Scenario: " + get_description(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state) + behat_scenario + "\n"


def main():
	f = open("/home/robin/Dev/moodle/blocks/evasys_sync/tests/behat/fulltest.feature", "w")
	x = ""
	i = 0
	x += tags + "\n"
	x += "Feature: " + feature_desc + "\n\n"
	x += background + "\n\n\n"
	for auto_mode in automode:
		for time_mode in standardtimemode:
			for studenoptions in students:
				for idnum in idnumber:
					for map in mapped:
						for istate in internalstate:
							for astate in actualstate:
								i += 1
								x += make_scenario(auto_mode, time_mode, studenoptions, idnum, map, istate, astate)

	f.write(x)
	f.close()
	print("Created %i testcases" % i)


main()
