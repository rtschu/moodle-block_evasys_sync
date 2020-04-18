from generator import coursename, lsfcourseid
import random
# Background
background = '  Background:\n\
    Given the following "users" exist:\n\
      | username | firstname | lastname | email |\n\
      | teacher1 | Teacher | 1 | teacher1@example.com |\n\
      | student1 | Student | 1 | student1@example.com |\n\
      | tutor1   | Tutor   | 1 | tutor1@example.com | \n\
    And the following "courses" exist:\n\
      | fullname | shortname | category |\n\
      | Course 1 | C1 | 0 |\n\
    And the following "course enrolments" exist:\n\
      | user | course | role |\n\
      | teacher1 | C1 | editingteacher |\n\
    And I log in as "teacher1"\n\
    And I am on "Course 1" course homepage'

feature_desc = "Tests all use-cases of the Evasys-block"

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
    "one": "If there are any mapped courses I should see those\n",
    "multi": "If there are any mapped courses I should see those\n"
}

# Environment configuration

manual_auto_mode = {
    "manual": "Given category {{category}} is in manual mode",
    "auto": "Given category {{category}} is in auto mode"
}

standardtimeMode = {
    0: "And category {{category}} is not in standardtime mode",
    1: "And category {{category}} is in standardtime mode with dates 1581043586 1582043586"
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
    "manual": "And I should see a button named \"Request evaluation\"",
    "auto": 'And I should see a button named "Set evaluation period"'
}

standardtimemode_checks = {
    0: "And I should not see \"Alter evaluationperiod for special courses\"",
    1: 'And I should see "Alter evaluationperiod for special courses"'
}

student_checks = {
    "none": "And I should see \"This course does not contain any students that can evaluate it.\"\n",
    "onlytutors": 'And I should see \"This course does not contain any students that can evaluate it.\"\n',
    "multi": ""
}

idnumber_checks = {
    "none": "",
    "invalid": "Then I should see \"The hard linked evasys-course is invalid!\"\n",
    "one": ""
}

mapped_checks = {
    "none": "",
    "invalid": "Then I should see \"One of the dynamically mapped evasys-courses is invalid\"\n",
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

selector_disabled_checks = {
    "both": "And both selectors should be disabled\n",
    "start": "And the startselector should be disabled\n",
    "none": ""
}

# The following Methods create Gherkin-tables to be used by the behat-functions of the Evasys-Plugin.
# Most of the tables specify a connection or entity per line.

# relations.
def evasys_relations(shortname, idnumber, semestertxt, veranstnr):
    """
    Specifies a Moodlecourse - Evasyscourse connection and creates the necessary lsf-course in the Process.
    One connection per table row
    :param shortname: Shortname of the moodle-course
    :param idnumber: idnumber to use in moodle-course and lsf-identifier
    :param semestertxt: semestertxt to use in lsf-course and evasys-identifier
    :param veranstnr: veranstnr to use in lsf-course and evasys-identifier
    :return: string A behat-table that specifies a full connection from a learnweb-course to a evasys-course
    Format: | Shortname | idnumber | semestertxt | veranstnr |
    """
    x = "And The following Evasys relations exist:\n" \
        "  | shortname | idnumber | semestertxt | veranstnr |\n"
    for i in range(0, len(shortname)):
        x += "  | " + shortname[i] + " | " + idnumber[i] + " | " + semestertxt[i] + " | " + veranstnr[i] + " |\n"
    return x


def lsf_evasys_surveys(courseshortname, lsfcourses, semsestertxt, veranstnr):
    """
    Specifies which evasys-courses should be mapped to a specific moodle-course and creates the necessary lsf-courses.
    One evasys-course per row BUT all these will be mapped to a single moodle-course.
    :param courseshortname: Shortname of the moodle course
    :param lsfcourses: lsfcourseid's to map (what would be the idnumber)
    :param semsestertxt: semestertxt of the created lsfcourse and evasys-id
    :param veranstnr: veranstnr of lsfcourse and evasys-id
    :return: string a behat tablt that specifies which lsf-courses were mapped to a single moodle-course
    Format: | lsfcourse | semestertxt | veranstnr |
    """
    x = "And the course with shortname " + str(courseshortname) + " has the following lsfcourses mapped:\n" \
                                                                  "  | lsfcourse | semestertxt | veranstnr |\n"
    for i in range(0, len(lsfcourses)):
        x += "  | " + lsfcourses[i] + " | " + semsestertxt[i] + " | " + veranstnr[i] + " |\n"
    return x


# entitys
def evasys_courses(evasysid, title, studentcount):
    """
    Specifies which evasys-courses should exist.
    One evasys-course per line.
    :param evasysid: Evasysid
    :param title: Title of evasys-course
    :param studentcount: number of students synced to the evasys-course
    :return: string A behat table that specifies multiple evasys-courses
    Format: | Evasysid | Title | Studentcount |
    """
    x = "And The following evasys courses exist:\n" \
        "  | evasysid | title  | studentcount |\n"
    for i in range(0, len(evasysid)):
        x += "  | " + evasysid[i] + " | " + title[i] + " | " + studentcount[i] + " |\n"
    return x


def evasys_forms(formid):
    """
    Specifies which evasys-forms should exist.
    One form per row.
    :param formid: Formid of the evasys-form
    :return: string a behat table that specifies multiple evasysforms
    Format: | Id | Name | Title |
    """
    x = "And The following Forms exist:\n" \
        "  | id | name  | title |\n"
    for i in range(0, len(formid)):
        x += "  | " + str(formid[i]) + " | " + "AAAA" + str(formid[i]) + " | " + "Testformnr. " + str(
            formid[i]) + " |\n"
    return x


def evasys_surveys(evasys_course, title, formid, open, completed=-1):
    """
    Specifies what evasys-surveys should exist. The referenced evasys-course has to exist.
    One survey per row.
    :param evasys_course: referenced evasys-course
    :param title: Title of the survey
    :param formid: Formid of the survey
    :param open: wether the survey is open
    :param completed: number of students that completed the survey
    :return: string a behat-table that specifies multiple evasys-surveys
    Format: | course | title | formid | open | completed |
    """
    x = "And The following surveys exist:\n" \
        "  | course | title  | formid | open | completed |\n"
    for i in range(0, len(evasys_course)):
        if not isinstance(completed, list):
            x += "  | " + str(evasys_course[i]) + " | " + str(title[i]) + " | " + str(formid[i]) + " | " + str(
                open[i]) + " | " + str(random.randrange(200) + 1) + " |\n"
        else:
            x += "  | " + str(evasys_course[i]) + " | " + str(title[i]) + " | " + str(formid[i]) + " | " + str(
                open[i]) + " | " + str(completed[i]) + " |\n"
    return x


# The following Methods help to construct Behat steps.
# There are only methods when using a dict (like above) is either unnecessarry complicated
# needs preparation (from a state like "multi" to an array of surveys)
# or something has to be added programatically (like coursenames or ids)
lsfcourseid = 0


def idnumberState(state, openstate):
    """
    :param state: idnumber state (none/invalid/one)
    :return: String either creating none, an invalid or one evasys-course - moodle-course link via idnumber
    """
    global lsfcourseid
    if state == "none":
        return "And there is no idnumber mapped to course " + coursename + "\n"
    elif state == "invalid":
        return "And the idnumber for course " + coursename + " is invalid\n"
    elif state == "one":
        x = "And the idnumber of course " + coursename + " links to a " + openstate + " Evasyscourse" + "\n"
        return x


def mappedState(state, openstate):
    """
    :param state: mapped state (none/invalid/one/multi)
    :return: a string creating none, only invalid, one or multiple mappings of a moodle-course to evasys-courses
    """
    global lsfcourseid
    if state == "none":
        return "And no courses are mapped to course " + coursename + "\n"
    elif state == "invalid":
        return "And only invalid mappings are present for course " + coursename + "\n"
    elif state == "one":
        x = "And there are 1 " + openstate + " Evasyscourses mapped to course with shortname " + coursename + "\n"
        return x
    elif state == "multi":
        x = "And there are 2 " + openstate + " Evasyscourses mapped to course with shortname " + coursename + "\n"
        return x


def makeEvasysSurveys(state):
    """
    creates the necessary data for the evasys_surveys function given a state, and returns the result for these
    :param state: State of the surveys (open/closed/mixed)
    :return: String creating surveys of the specified state
    """
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
    """
    creates the necessary data for <lsfcourseid> many evasys-courses and returns this as a table of evasys-courses
    :return: string table that creates evasys-courses
    """
    global lsfcourseid
    if lsfcourseid < 1:
        return ""
    x = "And the following evasys courses exist:\n"
    x += "  | evasysid | title | studentcount |\n"
    for i in range(0, lsfcourseid):
        x += "  | " + str(i) + " WS 2018/19 | Evatestcourse " + str(i) + " | 200 |\n"
    return x


def checks_standardtimemode(standardtime, auto_mode, internal_state, actual_state):
    """
    The standardtimemode check is a little tricky since the checkbox showing is dependent on 3 states
    :param standardtime: standardtimemode
    :param auto_mode: auto or manual mode
    :param internal_state: internal state
    :return: A string checking for the presence or absence of the standardtime checkbox
    """
    if standardtime == 1 and auto_mode == "manual" and (internal_state == "none" or internal_state == "notopened"):
        return standardtimemode_checks[1]
    return standardtimemode_checks[0]


def checks_internalstate(internal_state, actual_state, student_state, no_valid_mappings, mode, standardtime):
    checks = ""
    if standardtime and mode == "manual" and internal_state == "none":
        return selector_disabled_checks["both"]
    if no_valid_mappings:
        actual_state = "does_never_get_called"
    if ((internal_state == "opened" or internal_state == "closed" or (student_state == "none" or student_state == "onlytutors")
            and internal_state != "none")
            and not (internal_state == "closed" and (actual_state == "mixed" or actual_state == "open"))):
        if internal_state == "opened":
            checks += selector_disabled_checks["start"]
            if not (student_state == "none" or student_state == "onlytutors") and not no_valid_mappings:
                checks += "And the submitbutton should be enabled\n"
        else:
            checks += selector_disabled_checks["both"]
    elif (internal_state == "manual" or internal_state == "none") and \
            (actual_state == "mixed" or actual_state == "closed") and mode == "manual":
        checks += selector_disabled_checks["both"]
        if not actual_state == "closed" and not actual_state == "mixed":
            checks += internal_state_checks[internal_state]
    elif not no_valid_mappings and (internal_state == "notopened" or internal_state == "manual" or internal_state == "none"):
        if (internal_state == "manual" or internal_state == "none") and (actual_state == "closed" or actual_state == "mixed"):
            return ""
        checks += internal_state_checks[internal_state]
        if not (student_state == "none" or student_state == "onlytutors") and not no_valid_mappings:
            checks += "And the submitbutton should be enabled\n"
    return checks


def description_modeconsistency(mode, internal_state, actual_state):
    description = ""
    # check if there is a mismatch in internal_state and mode (i.E. auto mode but manually opened internal state)
    if ("manual" not in internal_state and "none" not in internal_state) and mode == {"manual"} or (
            internal_state == {"manual"} and mode != {"manual"}):
        description += "If there are inconsistent modes I should see a warning\n"
    # check if there is a mismatch between the internal state and the actual state (i.E. internal opened actually closed)
    if (actual_state != {"open"} and internal_state == {"opened"}) or (
            internal_state == {"closed"} and actual_state != {"closed"}):
        description += "If there are surveys that don't match the internal state I should see a warning\n"
    return description
