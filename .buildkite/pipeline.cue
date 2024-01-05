package bk

env: {
	BUILDKITE_GIT_MIRRORS_PATH:        "/cache/git"
	BUILDKITE_GIT_MIRRORS_SKIP_UPDATE: "1"
}

#RunAsUbuntu: securityContext: {
	runAsNonRoot: true
	runAsUser:    1000
	runAsGroup:   1000
}

#BashContainer: {
	imagePullPolicy: "Always"

	command: ["bash", "-c"]

	#RunAsUbuntu
}

steps: [{
	label: "buildkite-docker-image"
	plugins: [{
		kubernetes: podSpec: {
			containers: [{
				#BashContainer

				image: "cache.defn.run:5000/dfd:class-latest"
				args: ["""
					'set -e
					cd
					git fetch
					git reset --hard $BUILDKITE_COMMIT
					source .bash_profile
					cd m/i/class
					make buildkite'
					"""]

				volumeMounts: [{
					name:      "docker-socket"
					mountPath: "/var/run/docker.sock"
				}]
			}]
			volumes: [{
				name: "docker-socket"
				hostPath: path: "/var/run/docker.sock"
			}]
		}
	}]
}, {
	label: "bazel-build"
	plugins: [{
		kubernetes: podSpec: {
			containers: [{
				#BashContainer

				image: "cache.defn.run:5000/dfd:class-latest"
				args: ["""
					'set -e
					cd
					git fetch
					git reset --hard $BUILDKITE_COMMIT
					source .bash_profile
					git config --global user.email you@example.com
					git config --global user.name YourName
					bin/persist-cache
					cd m
					echo --- bazel
					export DFD_CI_BAZEL_OPTIONS=--remote_download_minimal
					../bin/b build
					echo --- bazel again
					../bin/b build'
					"""]

				volumeMounts: [{
					name:      "work"
					mountPath: "/home/ubuntu/work"
				}]
			}]
			volumes: [{
				name: "work"
				emptyDir: {}
			}]
		}
	}]
}, {
	label: "latest-class-docker-image"
	key:   "latest-class-docker-image"
	plugins: [{
		kubernetes: podSpec: {
			containers: [{
				#BashContainer

				image: "cache.defn.run:5000/dfd:class-latest"
				args: ["""
					'set -e
					cd
					git fetch
					git reset --hard $BUILDKITE_COMMIT
					source .bash_profile
					cd m/i/class
					make class-latest'
					"""]

				volumeMounts: [{
					name:      "docker-socket"
					mountPath: "/var/run/docker.sock"
				}]
			}]
			volumes: [{
				name: "docker-socket"
				hostPath: path: "/var/run/docker.sock"
			}]
		}
	}]
}, {
	label: "load-class-docker-image"
	plugins: [{
		kubernetes: podSpec: containers: [{
			#BashContainer

			image: "cache.defn.run:5000/dfd:class-latest"
			args: ["""
				'set -e
				cd
				echo --- git log
				git log | head'
				"""]
		}]
	}]
	depends_on: ["latest-class-docker-image"]
}]
