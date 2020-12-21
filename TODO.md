

* Initial MVP: provision, bind, unbind, unprovision
    * [ ] Provision with default plan
        * Use clusterServiceClassName and clusterServicePlanName
            * [ ] lookup ClusterServiceClass by service offering name
                * Find a way to add debugging/logging facility
                   * [x] as an unsupported spec field: gets ignored
                   * [x] as an annotation: persisted but restricted in size
                   * [x] as an OSB custom param
                * [x] define a debugging variable
                * [x] render the variable inside the spec
                * [ ] use lookup function
                    * [ ] inject mock of lookup response for unit tests
                * [ ] error if prereqs are not met with user friendly message
                   * using required function https://helm.sh/docs/howto/charts_tips_and_tricks/#using-the-required-function
                   * using failed function https://helm.sh/docs/chart_template_guide/function_list/#fail
            * [ ] lookup ClusterServicePlan by service plan name
        * [ ] Use clusterServiceClassExternalName and clusterServicePlanExternalName instead
    * [ ] Bind/unbind as release note command
        * [ ] using svcat cli
        * [ ] using kubectl
        * [ ] using distinct helm chart
    * [ ] Unprovisionning as chart release deletion: normal case
        * https://helm.sh/docs/helm/helm_uninstall/

* [ ] Add integration tests using KIND and a shelf hosted broker (minibroker/ CF overview service)
  * Benefits: automate end to end test including svcat bumps/regressions.

* [ ] Unprovisionning as chart release deletion: error case where svcat CR fail to delete
* [ ] Unprovisionning as chart release deletion: error case where underlying svcat CRs where modified by the user

* [ ] Bind/unbind as optional install-time step
    * [ ] Single binding
    * [ ] Unbinding when updating the chart with removing the binding value
        * https://helm.sh/docs/helm/helm_upgrade/
    * [ ] Multiple bindings
    * [ ] Binding parameters support without json schema
    * [ ] Binding parameters support with json schema

* [ ] Design the service instance plan upgrade use-case
    * [ ] Test the helm diff pluging previewing upgrade https://github.com/databus23/helm-diff
* [ ] Design the service instance custom params with JSon schema

* [ ] Design the service instance upgrade (i.e. use-opt-in to service instance upgrade)
    * Pending svcat maintenance_info support https://github.com/kubernetes-sigs/service-catalog/issues/2674
    * [ ] Release a new helm chart with README.md change list including
        * the last maintenance_info (e.g. available CVE and possible downtime)
        * the Osb2Helm chart generator versionning / params change
    * Q: How to publish a complete release note with history of the maintenance_info ?
        * the current OSB catalog.yml only contain the last maintenance_info
        * the helm chart repository might contain older versions
        * the helm chart generator might be provided latest version to propagate version history
        * rely on the user-provided description instead: https://helm.sh/docs/helm/helm_history/
    * [ ] Test upgrade https://helm.sh/docs/helm/helm_upgrade/
    * [ ] Test rollback https://helm.sh/docs/helm/helm_rollback/


* [ ] NOTES.txt mentionning the last upgraded step from maintenance_info


* [ ] investigate making the helm chart self contained with minimum prereqs
    * Possible alternative prereqs and associated helm chart features
        * [ ] install svcat
            * [ ] chart hooks: https://helm.sh/docs/topics/charts_hooks/ ?
            * [ ] chart dependency + conditional in template
        * [ ] instanciate ClusterServiceBroker
            * [ ] chart dependency + conditional in template
            * [ ] prompt user for the service broker login/password
            * [ ] embed the service broker login/password in the helm chart
                * the helm chart repo is protected with auth
                * the helm chart might contain audit trail of who asked for its generation, in order to track potential leaks when chart is distributed   
                * encrypt them as PGP. https://medium.com/@kuljeetsinghkhurana/pgp-with-helm-secrets-88401cf8dd50
                    * https://github.com/zendesk/helm-secrets
  


* [ ] format static NOTES.txt with
    * [ ] dashboard URL
    * [ ] current plan and cost
    * [ ] possible plan upgrades with cost
* [ ] dynamically generate NOTES.txt with
    * [ ] dashboard URL
    * [ ] current plan and cost
    * [ ] possible plan upgrades with cost

* [ ] format static README.md with
    * [ ] review best practices at https://helm.readthedocs.io/en/latest/awesome/
    * [ ] short description
    * [ ] long description
    * [ ] tags as keywords
        * [ ] review conventions and best practices at https://helm.readthedocs.io/en/latest/using_labels/
        * test it with https://helm.sh/docs/helm/helm_search/
    * [ ] image icon url
        * [ ] image data format
        * [ ] https url
* [ ] dynamically generate README.md with
    * Implementation alternatives
      * [ ] Try as an unused chart/template/README.md.yml
          * [ ] Q: how to render it ?
              * [ ] Using `helm template` https://helm.sh/docs/helm/helm_template/
      * [ ] Investigate further use of helm chart generators that generates README.md from chart/values.yml
         * [ ] https://github.com/kubepack/chart-doc-gen
         * [ ] https://github.com/norwoodj/helm-docs
         * [ ] frigate (from python community), see https://medium.com/rapids-ai/introducing-frigate-a-documentation-generation-tool-for-kubernetes-1791854031a1
      * Plain go templates https://godoc.org/text/template
    * [ ] short description
    * [ ] long description
    * [ ] tags
    * [ ] image icon url
        * [ ] image data format
        * [ ] https url

* [ ] Sign the generated helm chart to guarantee its provenance:
    * https://helm.sh/docs/topics/provenance/
    * https://helm.sh/docs/helm/helm_verify/

* [ ] Add smoke tests as chart test: start a service client and connect to it

* [ ] Design packaging an Osb2Helm generator component
    * [ ] A CLI binary which can be executed as part of a CI/CD pipeline. Takes as arguments: templates and osb
      catalog.yml
        * features
            * [ ] generate plain individual helm files (mostly Chart.md)
            * [ ] generate full helm tgz: https://helm.sh/docs/helm/helm_package/
            * [ ] push helm chart to a remote repository
                * plain http
                * artifactory api
                * oci registry https://helm.sh/docs/topics/registries/
        * alternative cli packaging options
            * [ ] plain cli
            * [ ] helm plugin https://helm.sh/docs/topics/plugins/
                * Many provide some flag parsing facitilies
                * provides access to the chart environment variables
    * [ ] A full HelmChartRepository serving index.yml along with tar.gz helm charts
        * Protected by auth (e.g. same login/password than the service broker) if ever service broker credentials are
          embedded in the helm chart
        * See https://helm.sh/docs/topics/chart_repository/#ordinary-web-servers
        * Add keywords matching the service broker metadata.
            * Test it with https://helm.sh/docs/helm/helm_search_repo/
        * In go: using go templating and similar unit testing framework than the helm chart
        * In java