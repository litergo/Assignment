import ProjectDescription
import ProjectDescriptionHelpers

let project = Project(name: "Assignment",
                      organizationName: "avmishchenko",
                      packages: packages,
                      targets: [
                        Target(name: "Assignment",
                               platform: .iOS,
                               product: .app,
                               bundleId: "ru.mishchenko.dev",
                               infoPlist: infoPlistPath,
                               sources: "Assignment/**",
                               resources: resourcesPaths,
                               dependencies: targetDependencies,
                               coreDataModels: coreDataModels)
                      ])
