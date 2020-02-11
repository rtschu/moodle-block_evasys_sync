import random
import copy

do_fast = False
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

# Descriptions
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
    "one": "If there are any mapped courses I should see those \n",
    "multi": "If there are any mapped courses I should see those \n"
}

# Environment configuration

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

# Checks

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

# Background
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
        x += "  | " + str(formid[i]) + " | " + "AAAA" + str(formid[i]) + " | " + "Testformnr. " + str(
            formid[i]) + " |\n"
    return x


def evasys_surveys(evasys_course, title, formid, open, completed=-1):
    x = "And The following surveys exist: \n" \
        "  | course | title  | formid | open | completed |\n"
    for i in range(0, len(evasys_course)):
        if not isinstance(completed, list):
            x += "  | " + str(evasys_course[i]) + " | " + str(title[i]) + " | " + str(formid[i]) + " | " + str(
                open[i]) + " | " + str(random.randrange(200) + 1) + " |\n"
        else:
            x += "  | " + str(evasys_course[i]) + " | " + str(title[i]) + " | " + str(formid[i]) + " | " + str(
                open[i]) + " | " + str(completed[i]) + " |\n"
    return x


def lsf_evasys_surveys(courseshortname, lsfcourses, semsestertxt, veranstnr):
    x = "And the course with shortname " + str(courseshortname) + " has the following lsfcourses mapped:\n" \
                                                                  "  | lsfcourse | semestertxt | veranstnr |\n"
    for i in range(0, len(lsfcourses)):
        x += "  | " + lsfcourses[i] + " | " + semsestertxt[i] + " | " + veranstnr[i] + " |\n"
    return x


lsfcourseid = 0


def idnumberState(state):
    global lsfcourseid
    if state == "none":
        return "And there is no idnumber mapped to course " + coursename + "\n"
    elif state == "invalid":
        return "And the idnumber for course " + coursename + " is invalid\n"
    elif state == "one":
        x = evasys_relations([coursename], [str(lsfcourseid)], ["WS 2018/19"], [str(lsfcourseid)])
        lsfcourseid += 1
        return x


def mappedState(state):
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


def makeEvasysSurveys(state):
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


def makeEvasysCourses():
    global lsfcourseid
    if lsfcourseid < 1:
        return ""
    x = "And the following evasys courses exist:\n"
    x += "  | evasysid | title | studentcount |\n"
    for i in range(0, lsfcourseid):
        x += "  | " + str(i) + " WS 2018/19 | Evatestcourse " + str(i) + " | 200 |\n"
    return x


def checks_standardtimemode(standardtime, automode, internal_state):
    if standardtime == 1 and automode == "auto" and (internal_state == "none" or internal_state == "manual"):
        return standardtimemode_checks[1]
    return standardtimemode_checks[0]


def get_checks(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
<<<<<<< HEAD
    checks = ""
    # If there are no mapped courses the Block not offer the option to "Show surveys"
    if (idnumber_state == "none") and (mapped_state == "none"):
        return "Then I should see \"Change mapping\"\n    And I should not see \"Name:\"\n"

    # In all other cases (even if there are only invalid entries) we need to click the button to start code execution
    checks += "And I press \"Show status of surveys\"\n"

    # First we want to check for idnumber and mapped checks. If there are invalid entries in either of these
    # there should be a warning. However, it should not disable the ability to request a evaluation or set a timeframe
    # in manual mode this was explicitly requested, and there might be an analog usecase in automatic mode.
    checks += idnumber_checks[idnumber_state]
    checks += mapped_checks[mapped_state]

    # if there is an internal state that is reserved for manual or automode we want to check we want to output
    # a warning if this is not in fact the correct mode
    if ((internal_state != "manual" and internal_state != "none") and mode == "manual") or (
            internal_state == "manual" and mode == "auto"):
        checks += inconsistent_mode + "\n"
    else:
        # if the internal state isn't conflicting we want to check, if the block is correctly displaying for that state
        checks += internal_state_checks[internal_state]
        # finally if there is no entry yet or the planned date is in the future we want to check that
        # there is an option to set the date for the evaluation
        if internal_state == "none" or (internal_state == "notopened" and mode == "auto"):
            checks += automode_checks[mode] + "\n"
    # If our own states don't match those of evasys we want to output a warning
    if internal_state == "closed" and actual_state != "closed":
        checks += "And I should see \"There are some open surveys, but all surveys should be closed.\"" + "\n"
    elif internal_state != "closed" and actual_state != "open":
        checks += "And I should see \"Some of the surveys have been closed ahead of schedule!\"" + "\n"

    # if the standardtimemodecheckbox should be present from the start we also want to check that
    checks += checks_standardtimemode(standardtime, automode, internal_state) + "\n"
    # if there are no students that are eligible to evaluate we want to output a warning
    checks += student_checks[students_state]
    checks = checks.replace("\n", "\n    ")
    return checks
=======
	checks = ""
	if (idnumber_state == "none" or idnumber_state == "invalid") and (mapped_state == "none" or mapped_state == "invalid"):
		if idnumber_state == "invalid" or mapped_state == "invalid":
			return "And I press \"Show status of surveys\"\n" + "Then I should see \"Change mapping\"\nAnd I should not see \"Name:\"\n"
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
>>>>>>> cc0cc54... corrected mistake


def get_description(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
    if mapped_state == "none" and idnumber_state == "none":
        return "If there are no related evasys-courses I should not see any.\n    "
    description = ""
    description += standardtimemode_descriptions[standardtime]
    description += students_descriptions[students_state]
    description += idnumber_descriptions[idnumber_state]
    description += mapped_descriptions[mapped_state]
    if ((internal_state != "manual" or internal_state != "none") and mode == "manual") or (
            internal_state == "manual" and mode != "manual"):
        description += "If there are inconsistent modes I should see a warning\n"
    if (actual_state != "open" and internal_state == "opened") or (
            internal_state == "closed" and actual_state != "closed"):
        description += "If there are surveys that don't match the internal state I should see a warning\n"
    description = description.replace("\n", "\n    ")
    return description


def get_combi_sentence(set, dictionary, param_name):
    set2 = set.copy()
    last_response = dictionary[set.pop()]
    while 1:
        if len(set) == 0:
            return last_response
        if not last_response == dictionary[set.pop()]:
            break
    sentence = last_response
    sentence += "This should be valid regardless of " + param_name + " being set to "
    while len(set2) > 1:
        sentence += str(set2.pop()) + ", "
    sentence = sentence[:len(sentence)-2]
    sentence += " or " + str(set2.pop()) + "\n"
    return sentence


def get_combi_description(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
    if "none" in mapped_state and "none" in idnumber_state:
        return "If there are no related evasys-courses I should not see any.\n    "
    description = ""
    description += get_combi_sentence(standardtime, standardtimemode_descriptions, "standardtime")
    description += get_combi_sentence(students_state, students_descriptions, "number of students")
    description += get_combi_sentence(idnumber_state, idnumber_descriptions, "idnumber")
    description += get_combi_sentence(mapped_state, mapped_descriptions, "mapped courses")
    if ("manual" not in internal_state and "none" not in internal_state) and mode == {"manual"} or (
            internal_state == {"manual"} and mode != {"manual"}):
        description += "If there are inconsistent modes I should see a warning\n"
    if (actual_state != {"open"} and internal_state == {"opened"}) or (
            internal_state == {"closed"} and actual_state != {"closed"}):
        description += "If there are surveys that don't match the internal state I should see a warning\n"
    description = description.replace("\n", "\n    ")
    return description


def get_scenario(mode, standardtime, students_state, idnumber_state, mapped_state, internal_state, actual_state):
    global lsfcourseid
    lsfcourseid = 0
    behat_scenario = manual_auto_mode[mode].replace("{{category}}", str(category)) + "\n"
    behat_scenario += standardtimeMode[standardtime].replace("{{category}}", str(category)) + "\n"
    behat_scenario += studentsState[students_state] + "\n"
    behat_scenario += idnumberState(idnumber_state)
    behat_scenario += mappedState(mapped_state)
    behat_scenario += evasys_forms([1])
    behat_scenario += internalState[internal_state].replace("{{course}}", str(coursename)) + "\n"
    behat_scenario += makeEvasysCourses()
    behat_scenario += makeEvasysSurveys(actual_state)

    behat_scenario += "And I turn editing mode on\n"
    behat_scenario += "And I add the \"EvaSys Sync\" block\n"
    behat_scenario += "And I turn editing mode off\n"
    behat_scenario = behat_scenario.replace("\n", "\n    ")

    if actual_state == "mixed" and lsfcourseid < 2:
        return ""
    return behat_scenario


def make_scenario(description, scenario, checks):
    return "  Scenario: " + description + scenario + checks + "\n"


def count_full_scenarios(condesed_array):
    i = 0
    for array in condesed_array:
        j = 1
        for param in array:
            j *= len(param)
        i += j
    return i


def array_diff(array1, array2):
    diff = 0
    position = 0
    for i in range(0, len(array1)):
        if not array1[i] == array2[i]:
            position = i
            diff += 1
    return diff, position


def condense_keep_options(fullarray):
    changed = True
    for i in range(0, len(fullarray)):
        for j in range(0, len(fullarray[i])):
            fullarray[i][j] = set([fullarray[i][j]])  # Do not replace with literal!
    while changed:
        new_array = copy.deepcopy(fullarray)
        changed = False
        for array in fullarray:
            for array2 in fullarray:
                diffcount, index = array_diff(array, array2)
                if diffcount == 1:
                    changed = True
                    if array2 in new_array:
                        new_array.remove(array2)
                    if array in new_array:
                        new_array.remove(array)
                    tmp = copy.deepcopy(array)
                    tmp[index] = array[index].union(array2[index])
                    new_array.append(tmp)
                    break
            if changed and not do_fast:
                break
        fullarray = new_array
    return fullarray


def main():
    f = open("test.feature", "w")
    # f = open("/home/robintschudi/Dev/moodle38/blocks/evasys_sync/tests/behat/fulltest.feature", "w")
    x = ""
    i = 0
    x += tags + "\n"
    x += "Feature: " + feature_desc + "\n\n"
    x += background + "\n\n\n"
    uncondensed_dict = {}
    for auto_mode in automode:
        for time_mode in standardtimemode:
            for studenoptions in students:
                for idnum in idnumber:
                    for map in mapped:
                        for istate in internalstate:
                            for astate in actualstate:
                                i += 1
                                check = get_checks(auto_mode, time_mode, studenoptions, idnum, map, istate, astate)
                                if not check in uncondensed_dict.keys():
                                    uncondensed_dict[check] = []
                                uncondensed_dict[check].append(
                                    [auto_mode, time_mode, studenoptions, idnum, map, istate, astate])

    condensed_dict = {}
    for check in uncondensed_dict.keys():
        scenarios = uncondensed_dict[check]
        condensed_dict[check] = condense_keep_options(scenarios)

    testcases = 0
    endcases = 0
    for check in condensed_dict.keys():
        # print(check)
        # print("(Automode, standartimemode, enrolled_students, idnum, mapped, internal, external)")
        for scenario in condensed_dict[check]:
            testcases += 1
            # print(scenario)
        endcases += count_full_scenarios(condensed_dict[check])
        # print("\n")

    for check in condensed_dict.keys():
        for scenario in condensed_dict[check]:
            scenario_copy = copy.deepcopy(scenario)
            desc = get_combi_description(scenario[0], scenario[1], scenario[2], scenario[3], scenario[4], scenario[5], scenario[6])
            scen_text = get_scenario(scenario_copy[0].pop(), scenario_copy[1].pop(), scenario_copy[2].pop(), scenario_copy[3].pop(),
                                     scenario_copy[4].pop(), scenario_copy[5].pop(), scenario_copy[6].pop())
            x += make_scenario(desc, scen_text, check)


    print("Startcases: %i, Endcases: %i" % (i, endcases))
    f.write(x)
    f.close()
    print("Condensed %i testcases to %i testcases with %i scenarios" % (i, testcases, len(condensed_dict)))


main()
