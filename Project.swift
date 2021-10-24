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
                               coreDataModels: coreDataModels),
                        Target(name: "AssignmentTests",
                               platform: .iOS,
                               product: .unitTests,
                               bundleId: "ru.mishchenko.dev.tests",
                               infoPlist: "AssignmentTests/Info.plist",
                               sources: ["AssignmentTests/**"],
                               dependencies: [.target(name: "Assignment")])
                      ])
