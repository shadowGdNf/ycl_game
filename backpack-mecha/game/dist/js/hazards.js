const angleDiff = (a, b) => Math.atan2(Math.sin(a - b), Math.cos(a - b));
export function contains(z, p, radius = 0) {
    const dx = p.x - z.x, dy = p.y - z.y, d = Math.hypot(dx, dy);
    if (z.kind === 'circle')
        return d <= z.radius + radius;
    if (z.kind === 'ring' && z.gapWidth && Math.abs(angleDiff(Math.atan2(dy, dx), z.gapAngle ?? 0)) + Math.asin(Math.min(1, radius / Math.max(d, 1))) < z.gapWidth / 2)
        return false;
    if (z.kind === 'ring')
        return d <= z.radius + radius && d >= Math.max(0, (z.innerRadius ?? z.radius - 22) - radius);
    if (z.kind === 'cone')
        return d <= z.radius + radius && d >= Math.max(0, (z.innerRadius || 0) - radius) && Math.abs(angleDiff(Math.atan2(dy, dx), z.angle)) <= (z.width || Math.PI / 2) / 2 + Math.asin(Math.min(1, radius / Math.max(d, 1)));
    const along = dx * Math.cos(z.angle) + dy * Math.sin(z.angle), across = -dx * Math.sin(z.angle) + dy * Math.cos(z.angle);
    return along >= -radius && along <= (z.w || z.radius) + radius && Math.abs(across) <= (z.h || z.width || 20) / 2 + radius;
}
