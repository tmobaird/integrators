# Integrator

Let's practice integrating with all sorts of HTTP APIs

### Roadmap

- [x] JSON GET list (https://dogapi.dog/docs/api-v2)
- [x] JSON GET one (https://dogapi.dog/docs/api-v2)
- [x] Pagination via query params
- [x] Filtering via query params
- [x] JSON POST (https://restful-api.dev/)
- [x] JSON PUT (https://restful-api.dev/)
- [x] JSON DELETE (https://restful-api.dev/)
- [x] Api Key Authentication (openai api)
- [x] OAuth (https://developers.google.com/analytics/)
- [ ] Basic authentication (jira)
- [ ] Graphql (github api)
- [ ] Error handling
- [ ] XML GET list (http://api.nbp.pl/en.html)
- [ ] XML GET one
- [ ] XML POST
- [ ] CSV GET list
- [ ] Binary get - image (https://cataas.com/)
- [ ] Streaming (openai api)
- [ ] SOAP

### What should writes look like

cli <api> <action> <args> <fields>

cli dogs create name="german shepherd"
cli dogs update 2 name="german hounddog" height=20