const levels = ['forest', 'desert', 'ocean'];
exports.searchLevels = (query) => levels.filter((name) => name.includes(query));
