// jest.config.js
exports.default = {
    testEnvironment: 'node',
    transform: {
      '^.+\\.js$': 'babel-jest',
    },
    coverageReporters: ["lcov", "text"],
    moduleFileExtensions: ['js'],
    collectCoverage: true,
    collectCoverageFrom: ['src/**/{!(app),}.js']
};