const COLORS = { p: 'pink', y: 'yellow', m: 'mint', v: 'purple' };
function make(id, name, subtitle, queues, cups, bufferSize, solution) {
    return { id, name, subtitle, queues: queues.map(q => [...q].map(c => COLORS[c])),
        cups: cups.map(c => ({ color: COLORS[c[0]], capacity: Number(c.slice(1)) })),
        bufferSize, solution, par: solution.length };
}
/** Twenty seeded, curated puzzles with replay-proven solutions.
 * Chute strings are front-first: p pink, y yellow, m mint, v purple.
 * Early levels teach the rules; later stages add colors, chutes, and ordering pressure.
 * Offline random-policy simulation orders puzzles within each stage; this is not user data. */
export const LEVELS = [
    make(1, "First Pour", "Tap a chute. Fill a matching cup.", ["pp", "yy", "p", "y"], ["p3", "y3"], 6, [0, 1, 2, 3]),
    make(2, "Sweet Company", "Full cups leave. New cups move in.", ["ppy", "yyp", "mmp", "mpp"], ["p3", "y3", "m3", "p3"], 6, [0, 1, 2, 0, 1, 2, 3, 3]),
    make(3, "Three’s a Charm", "Follow the colors, one sweet batch at a time.", ["ppm", "yyp", "mmy", "pym"], ["p2", "y2", "m2", "p2", "y2", "m2"], 6, [0, 1, 2, 0, 1, 2, 3, 3, 3]),
    make(4, "Make Some Room", "Waiting candy catches the next matching cup.", ["ppp", "mmpppp", "myyyym", "yymmpp"], ["p3", "y3", "p3", "p3", "y3", "m3", "m3"], 6, [0, 3, 2, 2, 1, 1, 3, 3, 2]),
    make(5, "Little Detour", "Look at the next cups before opening a chute.", ["mmpymm", "ppyp", "mmyypppp", "pyy"], ["m3", "y3", "y3", "m3", "p3", "p3", "p3"], 6, [0, 2, 2, 0, 0, 2, 0, 1, 1, 1, 3, 3]),
    make(6, "Purple Haze", "Four colors. Three cup spots. Choose your order.", ["ymmvv", "yyyppyvv", "pppymm", "pmmvv"], ["m3", "p3", "v3", "p3", "v3", "y3", "y3", "m3"], 6, [2, 3, 3, 3, 0, 0, 0, 2, 1, 1, 1, 1, 2]),
    make(7, "Pocket Full", "A little room in the tray goes a long way.", ["vyypppp", "vvyymmm", "yppmmm", "yvvv"], ["y3", "y3", "m3", "p3", "m3", "v3", "p3", "v3"], 6, [2, 3, 0, 0, 0, 1, 1, 1, 3, 2, 2]),
    make(8, "Sugar Shuffle", "Clear a cup to set a waiting color free.", ["vv", "mmmppp", "yyvvv", "yyyyv", "pppmmm"], ["y3", "v3", "y3", "m3", "v3", "p3", "m3", "p3"], 6, [3, 1, 0, 2, 1, 2, 4, 4, 3]),
    make(9, "Color Cascade", "One full cup can start a sweet chain reaction.", ["mvvv", "pyyy", "pppppyy", "pppvvv", "mmmmmy"], ["m3", "m3", "y3", "p3", "v3", "p3", "p3", "y3", "v3"], 6, [4, 3, 3, 2, 2, 0, 1, 0, 1, 4]),
    make(10, "Halfway Sweet", "Read the chutes from the bottom up.", ["mmmyyy", "yyyvvmmmvv", "yymmv", "ppppppvvv", "pppppp"], ["p4", "p4", "y4", "y4", "m4", "v4", "m4", "p4", "v4"], 6, [3, 1, 2, 0, 0, 3, 2, 4, 1, 1, 1, 2]),
    make(11, "Candy Crossroads", "Two good-looking moves. Think one cup ahead.", ["vvymvppp", "myvvmpp", "mmyyyppp", "yypppmmm", "ypvvv"], ["y4", "m4", "p4", "m4", "y4", "v4", "v4", "p4", "p4"], 6, [2, 2, 2, 1, 1, 4, 4, 3, 0, 0, 4, 1, 0, 0, 0, 3, 3, 1, 1]),
    make(12, "Double Scoop", "Some batches need more than one cup.", ["yyyyyyvvpp", "ppmmmyyy", "vvvpppvv", "yyymppp", "mmmmppv"], ["m4", "y4", "y4", "y4", "p4", "v4", "m4", "v4", "p4", "p4"], 6, [0, 4, 3, 2, 2, 0, 0, 2, 3, 1, 1, 1, 3, 4, 4]),
    make(13, "The Long Pour", "Save room before you release a big batch.", ["ppppmmmyy", "pppyyyvvv", "ypyymm", "yyyyp", "pppmmmvvvvv"], ["v4", "p4", "p4", "y4", "p4", "m4", "m4", "v4", "y4", "y4"], 6, [0, 3, 1, 4, 0, 4, 4, 3, 2, 2, 1, 1, 0, 2, 2]),
    make(14, "Sweet Switch", "A new cup can rescue the waiting tray.", ["yymmyyyy", "mmvvyv", "pppvvv", "pppyyyvy", "mmmppp", "pmpypv"], ["v4", "p4", "y4", "m4", "p4", "y4", "y4", "v4", "p4", "m4"], 6, [2, 2, 0, 5, 4, 5, 3, 3, 3, 3, 5, 5, 5, 5, 0, 0, 4, 1, 1, 1, 1]),
    make(15, "Tight Squeeze", "Every space in the waiting tray matters.", ["ppmmmvvyyy", "yyyvvp", "mvvmmp", "vppypyy", "mmmmmpppyy", "vmppy"], ["p4", "m4", "v4", "y4", "p4", "y4", "v4", "m4", "y4", "m4", "p4"], 6, [4, 1, 4, 0, 1, 4, 1, 3, 3, 3, 5, 2, 2, 3, 3, 2, 2, 5, 0, 0, 0, 5, 5]),
    make(16, "Ripple Effect", "Make one cup lead neatly into the next.", ["vyyyyy", "mppyyymm", "vvvmmppp", "mmpppp", "mmvvvvppp", "yyyymmm"], ["y4", "p4", "m4", "m4", "p4", "y4", "v4", "v4", "p4", "m4", "y4"], 6, [5, 5, 3, 3, 4, 1, 4, 2, 4, 1, 1, 0, 0, 1, 2, 2]),
    make(17, "Sugar Rush", "Keep the colors moving, not the tray filling.", ["pyvvyyy", "mmmpyy", "mmmyyvyy", "mpppyypp", "mmmvvvvv", "mmppppp"], ["m4", "v4", "p4", "p4", "m4", "y4", "p4", "y4", "y4", "v4", "m4"], 6, [1, 0, 1, 3, 3, 0, 0, 1, 3, 3, 2, 5, 5, 0, 2, 2, 2, 4, 4]),
    make(18, "The Last Gap", "Leave yourself one useful opening.", ["vvvyppmmm", "vyypmpp", "ppppppp", "mmyyymmm", "vmvvyymm", "vvvyvvyyy"], ["y4", "p4", "y4", "v4", "m4", "v4", "m4", "p4", "y4", "p4", "v4", "m4"], 6, [2, 0, 0, 1, 1, 3, 3, 3, 5, 4, 1, 1, 4, 5, 0, 0, 1, 4, 5, 5, 4, 4]),
    make(19, "Almost a Master", "Plan the chain before you open the chute.", ["mmmmy", "vvvmyyvvv", "yyyyyppvv", "vvvmvp", "yyymmmmpp", "mmppyppppp"], ["m4", "y4", "m4", "p4", "y4", "y4", "p4", "v4", "v4", "v4", "p4", "m4"], 6, [0, 2, 4, 4, 2, 4, 1, 3, 2, 0, 1, 1, 1, 3, 3, 3, 5, 5, 5, 5]),
    make(20, "Master Mixer", "Your final recipe: patience, color, and flow.", ["ymmmp", "myyyyvvv", "mmmyyyyppp", "ppmmvvvv", "yyyvvppp", "pvmmmvvpp"], ["y4", "m4", "p4", "v4", "p4", "m4", "v4", "m4", "v4", "y4", "y4", "p4"], 6, [2, 2, 2, 3, 3, 3, 1, 5, 5, 5, 5, 5, 0, 0, 1, 1, 4, 4, 4, 0]),
];
