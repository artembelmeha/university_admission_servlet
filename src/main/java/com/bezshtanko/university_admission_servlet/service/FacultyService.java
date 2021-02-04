package com.bezshtanko.university_admission_servlet.service;

import com.bezshtanko.university_admission_servlet.dao.interfaces.EnrollmentDao;
import com.bezshtanko.university_admission_servlet.dao.interfaces.FacultyDao;
import com.bezshtanko.university_admission_servlet.exception.FacultyNotExistException;
import com.bezshtanko.university_admission_servlet.model.enrollment.Enrollment;
import com.bezshtanko.university_admission_servlet.model.faculty.Faculty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;
import java.util.stream.Collectors;

public class FacultyService extends Service {

    private static final Logger log = LoggerFactory.getLogger(FacultyService.class);

    public void save(Faculty faculty) {
        try (FacultyDao facultyDao = daoFactory.createFacultyDao()) {
            facultyDao.save(faculty);
        }
    }

    public Faculty findById(Long id) {
        log.info("Getting faculty with id '{}'", id);
        try (FacultyDao facultyDao = daoFactory.createFacultyDao()) {
            return facultyDao.findById(id).orElseThrow(FacultyNotExistException::new);
        }
    }

    public List<Faculty> findAll() {
        log.info("Getting all faculties");
        try (FacultyDao facultyDao = daoFactory.createFacultyDao()) {
            return facultyDao.findAll();
        }
    }

    public Faculty findWithEnrollments(Long id) {
        log.info("Getting faculty with id: '{}' with enrollments", id);
        try (FacultyDao facultyDao = daoFactory.createFacultyDao();
             EnrollmentDao enrollmentDao = daoFactory.createEnrollmentDao()) {
            Faculty faculty = facultyDao.findById(id).orElseThrow(FacultyNotExistException::new);
            List<Enrollment> enrollments = enrollmentDao.findAllByFacultyId(id);
            faculty.setEnrollments(enrollments);
            return faculty;
        }
    }

    public Faculty findWithFinalList(Long id) {
        log.info("Getting faculty with id: '{}' with final list", id);
        try (FacultyDao facultyDao = daoFactory.createFacultyDao();
             EnrollmentDao enrollmentDao = daoFactory.createEnrollmentDao()) {
            Faculty faculty = facultyDao.findById(id).orElseThrow(FacultyNotExistException::new);
            List<Enrollment> enrollments = enrollmentDao.findAllFinalizedByFacultyId(id);
            faculty.setEnrollments(enrollments);
            return faculty;
        }
    }

    public void update(Faculty faculty) {
        log.info("Updating faculty with id '{}'", faculty.getId());
        try (FacultyDao facultyDao = daoFactory.createFacultyDao()) {
            facultyDao.update(faculty);
        }
    }

    public Faculty finalizeFaculty(Long id) {
        try (FacultyDao facultyDao = daoFactory.createFacultyDao();
             EnrollmentDao enrollmentDao = daoFactory.createEnrollmentDao()) {
            log.info("Finalization of faculty with id '{}' started", id);
            facultyDao.finalizeFaculty(id);
            log.info("Finalization finished successfully. Getting final list");

            Faculty faculty = facultyDao.findById(id).orElseThrow(FacultyNotExistException::new);
            faculty.setEnrollments(enrollmentDao.findAllByFacultyId(id)
                    .stream()
                    .filter(Enrollment::isFinalized)
                    .collect(Collectors.toList()));
            return faculty;
        }
    }

    public void deleteById(Long id) {
        log.info("Deleting faculty with id '{}'", id);
        try (FacultyDao facultyDao = daoFactory.createFacultyDao()) {
            facultyDao.deleteById(id);
            log.info("Faculty with id '{}' was successfully deleted", id);
        }
    }

}
