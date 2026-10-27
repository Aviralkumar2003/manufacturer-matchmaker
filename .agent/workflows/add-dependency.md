# Add or upgrade a dependency

Record the requirement and why existing approved components are insufficient. Research at least two candidates where practical using official release, registry, licence, maintenance, and advisory sources. Check installation scripts and transitive packages. Apply the project's 14-day release policy and pin exact versions in lockfiles.

Write the finding in `.agent/docs/DEPENDENCY_RESEARCH.md` and the proposed choice in `.agent/docs/DECISIONS.md`. Obtain founder approval before adding, upgrading, or substituting any dependency, as required by the approval paragraph in bootstrap section 3. Only then edit manifests, run the audit and `make verify`, and update the allowlist.
