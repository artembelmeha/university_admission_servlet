<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>

<fmt:setLocale value="${sessionScope.lang}"/>
<fmt:setBundle basename="i18n.messages"/>

<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title><fmt:message key="faculty.create.title"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
          integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
</head>
<body>

<jsp:include page="../fragments/bodyHeader.jsp"/>

<div class="container" style="margin-top: 60px">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <h2 class="page-header"><fmt:message key="faculty.create.header"/></h2>
            <form style="margin-bottom: 30px" name="form" autocomplete="off" th:action="@{/faculty/new}"
                  th:object="${faculty}" method="post">
                <div class="form-group">
                    <label for="nameUa"><fmt:message key="faculty.nameUa"/></label>
                    <br/><span class="error" style="color:red" th:if="${#fields.hasErrors('nameUa')}"
                               th:errors="*{nameUa}"></span>
                    <input id="nameUa"
                           type="text"
                           class="form-control"
                           th:field="*{nameUa}"
                           required>
                </div>
                <div class="form-group">
                    <label for="nameEn"><fmt:message key="faculty.nameEn"/></label>
                    <br/><span class="error" style="color:red" th:if="${#fields.hasErrors('nameEn')}"
                               th:errors="*{nameEn}"></span>
                    <input id="nameEn"
                           type="text"
                           class="form-control"
                           th:field="*{nameEn}"
                           required>
                </div>
                <div class="form-group">
                    <label for="descriptionUa"><fmt:message key="faculty.descriptionUa"/></label>
                    <br/><span class="error" style="color:red" th:if="${#fields.hasErrors('descriptionUa')}"
                               th:errors="*{descriptionUa}"></span>
                    <input id="descriptionUa"
                           type="text"
                           class="form-control"
                           th:field="*{descriptionUa}"
                           required>
                </div>
                <div class="form-group">
                    <label for="descriptionEn"><fmt:message key="faculty.descriptionEn"/></label>
                    <br/><span class="error" style="color:red" th:if="${#fields.hasErrors('descriptionEn')}"
                               th:errors="*{descriptionEn}"></span>
                    <input id="descriptionEn"
                           type="text"
                           class="form-control"
                           th:field="*{descriptionEn}"
                           required>
                </div>
                <div class="form-group">
                    <label for="stateFundedPlaces"><fmt:message key="faculty.stateFundedPlaces"/></label>
                    <br/><span class="error" style="color:red" th:if="${#fields.hasErrors('stateFundedPlaces')}"
                               th:errors="*{stateFundedPlaces}"></span>
                    <input id="stateFundedPlaces"
                           type="number"
                           class="form-control"
                           th:field="*{stateFundedPlaces}"
                           required>
                </div>
                <div class="form-group">
                    <label for="contractPlaces"><fmt:message key="faculty.contractPlaces"/></label>
                    <br/><span class="error" style="color:red" th:if="${#fields.hasErrors('contractPlaces')}"
                               th:errors="*{contractPlaces}"></span>
                    <input id="contractPlaces"
                           type="number"
                           class="form-control"
                           th:field="*{contractPlaces}"
                           required>
                </div>
                <div>
                    <p><b><fmt:message key="faculty.subjects"/> </b></p>
                    <label>
                        <input type="checkbox"
                               name="subjects"
                               class="check-box"
                               th:each="subject : ${faculty.subjects}"
                               th:utext="${' ' + subject.nameEn + ' (' + subject.type + ')'} + '<br />'"
                               th:value="${subject.id}"
                               th:field="*{subjects}"
                        />
                    </label>
                </div>
                <button type="submit" class="btn btn-default" style="margin-top:30px">
                    <fmt:message key="submit"/>
                </button>
            </form>
        </div>
    </div>
</div>
</body>
</html>